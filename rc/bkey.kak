#        ____
#       / __ )  __
#      / __  | / /_____ __ __
#     / /_/ / /  '_/ -_) // /
#    /_____/ /_/\_\\__/\_, /
#                     /___/

# File:         bkey.kak
# Description:  Kakoune key-binding that SuperB
# Author:       NNB
#               └─ https://github.com/NNBnh
# URL:          https://github.com/NNBnh/bkey-kak
# License:      GPLv3

#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.


# Setup
	# Mode
	declare-user-mode Menu
	declare-user-mode Menu-ex
	declare-user-mode View
	declare-user-mode Focus
	declare-user-mode Focus-begin
	declare-user-mode Focus-end
	declare-user-mode Focus-begin-ex
	declare-user-mode Focus-end-ex
	declare-user-mode FOCUS
	declare-user-mode FOCUS-begin
	declare-user-mode FOCUS-end
	declare-user-mode FOCUS-begin-ex
	declare-user-mode FOCUS-end-ex

	define-command -hidden bkey-menu         'enter-user-mode Menu'
	define-command -hidden bkey-menu-e       'enter-user-mode Menux-ex'
	define-command -hidden bkey-view         'enter-user-mode View'
	define-command -hidden bkey-view-lock    'enter-user-mode -lock View'
	define-command -hidden bkey-Focus        'enter-user-mode Focus'
	define-command -hidden bkey-Focus-p      'enter-user-mode Focus-begin'
	define-command -hidden bkey-Focus-n      'enter-user-mode Focus-end'
	define-command -hidden bkey-Focus-e-p    'enter-user-mode Focus-begin-ex'
	define-command -hidden bkey-Focus-e-n    'enter-user-mode Focus-end-ex'
	define-command -hidden bkey-FOCUS        'enter-user-mode FOCUS'
	define-command -hidden bkey-FOCUS-p      'enter-user-mode FOCUS-begin'
	define-command -hidden bkey-FOCUS-n      'enter-user-mode FOCUS-end'
	define-command -hidden bkey-FOCUS-e-p    'enter-user-mode FOCUS-begin-ex'
	define-command -hidden bkey-FOCUS-e-n    'enter-user-mode FOCUS-end-ex'

	# Movement
	define-command -hidden bkey-to-line %{
		evaluate-commands %sh{
			if [[ "${kak_count}" -gt '0' ]]; then
				if [[ "${1}" = 'e' ]]; then
					echo "execute-keys <G><g>${kak_count}<J><K>"
				else
					echo "execute-keys <g><g>${kak_count}<j><k>"
				fi
			fi
		}
		execute-keys <V><c><m><esc>
	}

	declare-option str bkey_move_buffer_echo
	set-option global bkey_move_buffer_echo "%val{bufname}"
	define-command -hidden bkey-buffer %{
		evaluate-commands %sh{
			case ${1} in
				'p') echo "buffer-previous" ;;
				'n') echo "buffer-next" ;;
				'd') echo "buffer *debug*" ;;
			esac
		}
		echo %opt{bkey_move_buffer_echo}
	}

	# define-command -hidden bkey-occur        ''
	# define-command -hidden bkey-occur-e      ''

	# Action
	define-command -hidden bkey-ins %{
		execute-keys %sh{
			if [[ "${kak_selection_desc%%.*}" -gt "${${kak_selection_desc##*,}%%.*}" ]] \
				|| [[ "${${kak_selection_desc%%,*}##*.}" -gt "${kak_selection_desc##*.}" ]]; then
				case "${1}" in
					'i')   echo "<a>" ;;
					'p')   echo "<l><i><space><esc><h><R>" ;;
					'pa')  echo "<l><i><space><esc><h><a-R>" ;;
					'pe')  echo "<p>" ;;
					'pea') echo "<a-p>" ;;
					'c')   echo "<a-!>" ;;
				esac
			else
				case "${1}" in
					'i')   echo "<i>" ;;
					'p')   echo "<i><space><esc><h><R>" ;;
					'pa')  echo "<i><space><esc><h><a-R>" ;;
					'pe')  echo "<P>" ;;
					'pea') echo "<a-P>" ;;
					'c')   echo "<!>" ;;
				esac
			fi
		}
	}

	# Environment
	define-command -hidden bkey-lines %{
		evaluate-commands %sh{
			reg_backup="${kak_reg_z}"
			echo "execute-keys <x><\"><z><d>${kak_count}"
			case "${1}" in
				'up')   echo "execute-keys <k>" ;;
				'down') echo "execute-keys <j>" ;;
				'UP')   echo "execute-keys <[><p>" ;;
				'DOWN') echo "execute-keys <]><p>" ;;
			esac
			echo "execute-keys <;><a-O><k><a-x><\"><z><R>"
			echo "set-register z \"${reg_backup}\""
		}
	}

	declare-option str bkey_save_echo
	set-option global bkey_save_echo "%val{client}@[%val{client_pid}] %val{buffile}"
	define-command -hidden bkey-save %{
		write
		echo %opt{bkey_save_echo}
	}

	define-command -hidden bkey-open-term 'terminal %val{client_env_SHELL}'

	# View
	# define-command -hidden bkey-linewrap ''

	# Insert
	hook global InsertCompletionShow .* %{
		try %{
			execute-keys -draft 'h<a-K>\h<ret>'
			map window insert  <tab>               '<c-n>'                                 -docstring ''
			map window insert  <s-tab>             '<c-p>'                                 -docstring ''
		}
	}
	hook global InsertCompletionHide .* %{
		unmap window insert <tab> '<c-n>'
		unmap window insert <s-tab> '<c-p>'
	}


# Mapping
	#TODO map global object  <t>  %{c<lt>([\w.]+)\b[^>]*?(?<lt>!/)>,<lt>/([\w.]+)\b[^>]*?(?<lt>!/)><ret>}  -docstring 'xml tag object'
define-command bkey-load %{
	evaluate-commands %sh{
		func_list=( "ind_left" "ind_right" "ind_up" "ind_down" "ind_pgup" "ind_pgdn" "ind_home" "ind_end" "ind_tab" "ind_bs" "ind_del" "ind_space" "ind_esc"
		            "mov_left" "mov_right" "mov_up" "mov_down" "mov_backward" "mov_forward" "mov_target" "mov_target_next" "mov_target_quick" "mov_quick" "mov_mark" "mov_item" "mov_select" "mov_focus" "mov_focus_prev" "mov_focus_next"
		            "act_prim" "act_secon" "act_alt" "act_cut" "act_in" "act_out" "act_edit"
		            "env_new" "env_group" "env_cmd" "env_term" "env_undo" "env_re" "env_record" "env_done" "env_code" "env_person"
		            "vie_look" "vie_minus" "vie_plus" "vie_mute" )

		func_ind_left=(               "<h>"                    "<H>"                    "<lt>"                   "<a-lt>"                 "<b>"                    "<B>"                    )
		func_ind_right=(              "<l>"                    "<L>"                    "<gt>"                   "<a-gt>"                 "<e>"                    "<E>"                    )
		func_ind_up=(                 "<k>"                    "<K>"                    ": bkey-lines up<ret>"   ": bkey-lines UP<ret>"   "<k>"                    "<K>"                    )
		func_ind_down=(               "<j>"                    "<J>"                    ": bkey-lines down<ret>" ": bkey-lines DOWN<ret>" "<j>"                    "<J>"                    )
		func_ind_pgup=(               "<c-b>"                  "<c-b>"                  ""                       ""                       "<c-u>"                  "<c-u>"                  )
		func_ind_pgdn=(               "<c-f>"                  "<c-f>"                  ""                       ""                       "<c-d>"                  "<c-d>"                  )
		func_ind_home=(               "<a-h>"                  "<a-H>"                  ""                       ""                       "<g><g>"                 "<G><g>"                 )
		func_ind_end=(                "<a-l>"                  "<a-L>"                  ""                       ""                       "<g><e>"                 "<G><e>"                 )
		func_ind_tab=(                ": bkey-buffer n<ret>"   ": bkey-buffer p<ret>"   ""                       ""                       ""                       ""                       )
		func_ind_bs=(                 "<;><h><a-d>"            ""                       ""                       ""                       ""                       ""                       )
		func_ind_del=(                "<;><a-d>"               ""                       ""                       ""                       ""                       ""                       )
		func_ind_space=(              ": bkey-menu<ret>"       ""                       ": bkey-menu-e<ret>"     ""                       ""                       ""                       )
		func_ind_esc=(                "<;>"                    ""                       ""                       ""                       ""                       ""                       )
		func_ind_enter=(              "<ret>"                  ""                       ""                       ""                       ""                       ""                       )
		func_mov_left=(               "<h>"                    "<a-h>"                  "<H>"                    "<a-H>"                  ""                       ""                       )
		func_mov_right=(              "<l>"                    "<a-l>"                  "<L>"                    "<a-L>"                  ""                       ""                       )
		func_mov_up=(                 "<k>"                    "<[>p"                   "<K>"                    "<{>p"                   ""                       ""                       )
		func_mov_down=(               "<j>"                    "<]>p"                   "<J>"                    "<}>p"                   ""                       ""                       )
		func_mov_backward=(           "<b>"                    "<a-b>"                  "<B>"                    "<a-B>"                  ""                       ""                       )
		func_mov_forward=(            "<e>"                    "<a-e>"                  "<E>"                    "<a-E>"                  ""                       ""                       )
		func_mov_target=(             "</>"                    "<a-/>"                  "<?>"                    "<a-?>"                  ""                       ""                       )
		func_mov_target_next=(        "<n>"                    "<a-n>"                  "<N>"                    "<a-N>"                  ""                       ""                       )
		func_mov_target_quick=(       "<f>"                    "<a-f>"                  "<F>"                    "<a-F>"                  ""                       ""                       )
		func_mov_quick=(              "<m>"                    "<a-m>"                  "<M>"                    "<a-M>"                  ""                       ""                       )
		func_mov_mark=(               "<z>"                    "<Z>"                    "<>"                     "<c-s>"                  ""                       ""                       )
		func_mov_item=(               "<(>"                    "<)>"                    "<a-(>"                  "<a-)>"                  ""                       ""                       )
		func_mov_select=(             "<a-x>"                  "<%>"                    "<a-x>"                  "<a-X>"                  ""                       ""                       )
		func_mov_focus=(              ": bkey-focus<ret>"      ": bkey-FOCUS<ret>"      "<a-;>"                  "<a-:>"                  ""                       ""                       )
		func_mov_focus_prev=(         ": bkey-focus-p<ret>"    ": bkey-FOCUS-p<ret>"    ": bkey-focus-e-p<ret>"  ": bkey-FOCUS-e-p<ret>"  ""                       ""                       )
		func_mov_focus_next=(         ": bkey-focus-n<ret>"    ": bkey-FOCUS-n<ret>"    ": bkey-focus-e-n<ret>"  ": bkey-FOCUS-e-n<ret>"  ""                       ""                       )
		func_act_prim=(               ": bkey-ins i<ret>"      "<A>"                    ""                       "<I>"                    ""                       ""                       )
		func_act_secon=(              "<u>"                    "<U>"                    "<c-o>"                  "<c-i>"                  ""                       ""                       )
		func_act_alt=(                "<a-c>"                  "<a-l><a-c>"             "<r>"                    ""                       ""                       ""                       )
		func_act_cut=(                "<d>"                    "<a-l><y>"               "<a-d>"                  "<a-l><a-d>"             ""                       ""                       )
		func_act_in=(                 "<y>"                    "<a-l><y>"               "<y>"                    "<a-L><y>"               ""                       ""                       )
		func_act_out=(                ": bkey-ins p<ret>"      "<R>"                    ": bkey-ins pe<ret>"     "<R>"                    ""                       ""                       )
		func_act_edit=(               "<space>"                "<a-space>"              "<_>"                    ""                       ""                       ""                       )
		func_env_new=(                "<a-o>"                  "<a-O>"                  "<C>"                    "<a-C>"                  ""                       ""                       )
		func_env_group=(              "<a-J>"                  "<a-_>"                  "<a-j>"                  ""                       ""                       ""                       )
		func_env_cmd=(                "<:>"                    ": bkey-ins c<ret>"      "<a-|>"                  "<|>"                    ""                       ""                       )
		func_env_term=(               ":terminal "             ": bkey-open-term<ret>"  "<a-|>"                  "<|>"                    ""                       ""                       )
		func_env_undo=(               "<u>"                    "<U>"                    "<a-u>"                  "<a-U>"                  ""                       ""                       )
		func_env_re=(                 "<a-.>"                  "<.>"                    ": bkey-occur-e<ret>"    ": bkey-occur<ret>"      ""                       ""                       )
		func_env_record=(             "<q>"                    "<Q>"                    ""                       "<esc>"                  ""                       ""                       )
		func_env_done=(               ": bkey-save<ret>"       ":terminal "             ""                       ""                       ""                       ""                       )
		func_env_code=(               "<'>"                    "<\\>"                   ": comment-line<ret>"    ": comment-block<ret>"   ""                       ""                       )
		func_env_person=(             "<.>"                    ""                       ""                       ""                       ""                       ""                       )
		func_vie_look=(               ": bkey-view<ret>"       ": bkey-view-lock<ret>"  ": bkey-linewrap<ret>"   ": bkey-linewrap<ret>"   ""                       ""                       )
		func_vie_minus=(              "<lt>"                   "<\`>"                   "<a-lt>"                 ""                       ""                       ""                       )
		func_vie_plus=(               "<gt>"                   "<~>"                    "<a-gt>"                 ""                       ""                       ""                       )
		func_vie_mute=(               "<&>"                    "<a-\`>"                 "<a-&>"                  ""                       ""                       ""                       )

		menu_ind_left=(               "<g><i>"                 "<g><h>"                 "<G><i>"                 "<G><h>"                 )
		menu_ind_right=(              "<g><l>"                 "<g><j>"                 "<G><l>"                 "<G><j>"                 )
		menu_ind_up=(                 "<g><g>"                 "<g><t>"                 "<G><g>"                 "<G><t>"                 )
		menu_ind_down=(               "<g><e>"                 "<g><b>"                 "<G><e>"                 "<G><b>"                 )
		menu_ind_pgup=(               ""                       ""                       ""                       ""                       )
		menu_ind_pgdn=(               ""                       ""                       ""                       ""                       )
		menu_ind_home=(               ""                       ""                       ""                       ""                       )
		menu_ind_end=(                ""                       ""                       ""                       ""                       )
		menu_ind_tab=(                ""                       ""                       ""                       ""                       )
		menu_ind_bs=(                 ""                       ""                       ""                       ""                       )
		menu_ind_del=(                ""                       ""                       ""                       ""                       )
		menu_ind_space=(              ": bkey-to-line<ret>"    ""                       ": bkey-to-line e<ret>"  ""                       )
		menu_ind_esc=(                ""                       ""                       ""                       ""                       )
		menu_ind_enter=(              "<g><f>"                 ""                       ""                       ""                       )
		menu_mov_left=(               "<g><i>"                 "<g><h>"                 "<G><i>"                 "<G><h>"                 )
		menu_mov_right=(              "<g><l>"                 "<g><j>"                 "<G><l>"                 "<G><j>"                 )
		menu_mov_up=(                 "<g><g>"                 "<g><t>"                 "<G><g>"                 "<G><t>"                 )
		menu_mov_down=(               "<g><e>"                 "<g><b>"                 "<G><e>"                 "<G><b>"                 )
		menu_mov_backward=(           "<c-u>"                  "<c-b>"                  ""                       ""                       )
		menu_mov_forward=(            "<c-d>"                  "<c-f>"                  ""                       ""                       )
		menu_mov_target=(             "<*>"                    "<a-*>"                  ""                       ""                       )
		menu_mov_target_next=(        ""                       ""                       ""                       ""                       )
		menu_mov_target_quick=(       "<t>"                    "<a-t>"                  "<T>"                    "<a-T>"                  )
		menu_mov_quick=(              "<g><f>"                 "<g><c>"                 "<G><f>"                 "<G><c>"                 )
		menu_mov_mark=(               "<a-z>"                  "<a-Z>"                  ""                       ""                       )
		menu_mov_item=(               ""                       ""                       ""                       ""                       )
		menu_mov_select=(             "<a-s>"                  "<a-S>"                  ""                       ""                       )
		menu_mov_focus=(              ""                       ""                       ""                       ""                       )
		menu_mov_focus_prev=(         ""                       ""                       ""                       ""                       )
		menu_mov_focus_next=(         ""                       ""                       ""                       ""                       )
		menu_act_prim=(               "<s>"                    "<S>"                    ""                       ""                       )
		menu_act_secon=(              ""                       ""                       ""                       ""                       )
		menu_act_alt=(                "<@>"                    "<a-@>"                  ""                       ""                       )
		menu_act_cut=(                ""                       ""                       ""                       ""                       )
		menu_act_in=(                 ""                       ""                       ""                       ""                       )
		menu_act_out=(                ": bkey-ins pa<ret>"     "<a-R>"                  ": bkey-ins pea<ret>"    ""                       )
		menu_act_edit=(               "<a-k>"                  "<a-K>"                  ""                       ""                       )
		menu_env_new=(                "<o>"                    "<O>"                    ""                       ""                       )
		menu_env_group=(              ""                       ""                       ""                       ""                       )
		menu_env_cmd=(                ""                       ""                       ""                       ""                       )
		menu_env_term=(               "<$>"                    ""                       ""                       ""                       )
		menu_env_undo=(               "<g><.>"                 "<g><a>"                 "<G><.>"                 "<G><a>"                 )
		menu_env_re=(                 ""                       ""                       ""                       ""                       )
		menu_env_record=(             ""                       ""                       ""                       ""                       )
		menu_env_done=(               ""                       ""                       ""                       ""                       )
		menu_env_code=(               ""                       ""                       ""                       ""                       )
		menu_env_person=(             ""                       ""                       ""                       ""                       )
		menu_vie_look=(               ""                       ""                       ""                       ""                       )
		menu_vie_minus=(              ""                       ""                       ""                       ""                       )
		menu_vie_plus=(               ""                       ""                       ""                       ""                       )
		menu_vie_mute=(               ""                       ""                       ""                       ""                       )

		view_ind_left=(               "<v><h>"                 "99999<v><h>"            )
		view_ind_right=(              "<v><l>"                 "99999<v><l>"            )
		view_ind_up=(                 "<v><k>"                 "<v><b>"                 )
		view_ind_down=(               "<v><j>"                 "<v><t>"                 )
		view_ind_pgup=(               ""                       ""                       )
		view_ind_pgdn=(               ""                       ""                       )
		view_ind_home=(               ""                       ""                       )
		view_ind_end=(                ""                       ""                       )
		view_ind_tab=(                ""                       ""                       )
		view_ind_bs=(                 ""                       ""                       )
		view_ind_del=(                ""                       ""                       )
		view_ind_space=(              ""                       ""                       )
		view_ind_esc=(                ""                       ""                       )
		view_ind_enter=(              ""                       ""                       )
		view_mov_left=(               "<v><h>"                 "99999<v><h>"            )
		view_mov_right=(              "<v><l>"                 "99999<v><l>"            )
		view_mov_up=(                 "<v><k>"                 "<v><b>"                 )
		view_mov_down=(               "<v><j>"                 "<v><t>"                 )
		view_mov_backward=(           "<c-u>"                  "<c-b>"                  )
		view_mov_forward=(            "<c-d>"                  "<c-f>"                  )
		view_mov_target=(             ""                       ""                       )
		view_mov_target_next=(        ""                       ""                       )
		view_mov_target_quick=(       ""                       ""                       )
		view_mov_quick=(              "<v><m>"                 "<v><c>"                 )
		view_mov_mark=(               ""                       ""                       )
		view_mov_item=(               ""                       ""                       )
		view_mov_select=(             ""                       ""                       )
		view_mov_focus=(              ""                       ""                       )
		view_mov_focus_prev=(         ""                       ""                       )
		view_mov_focus_next=(         ""                       ""                       )
		view_act_prim=(               ""                       ""                       )
		view_act_secon=(              ""                       ""                       )
		view_act_alt=(                ""                       ""                       )
		view_act_cut=(                ""                       ""                       )
		view_act_in=(                 ""                       ""                       )
		view_act_out=(                ""                       ""                       )
		view_act_edit=(               ""                       ""                       )
		view_env_new=(                ""                       ""                       )
		view_env_group=(              ""                       ""                       )
		view_env_cmd=(                ""                       ""                       )
		view_env_term=(               ""                       ""                       )
		view_env_undo=(               ""                       ""                       )
		view_env_re=(                 ""                       ""                       )
		view_env_record=(             ""                       ""                       )
		view_env_done=(               ""                       ""                       )
		view_env_code=(               ""                       ""                       )
		view_env_person=(             ""                       ""                       )
		view_vie_look=(               "<V><c><m><esc>"         ""                       )
		view_vie_minus=(              ""                       ""                       )
		view_vie_plus=(               ""                       ""                       )
		view_vie_mute=(               ""                       ""                       )

		focus_ind_left=(              "<b>"                    "<B>"                    )
		focus_ind_right=(             "<b>"                    "<B>"                    )
		focus_ind_up=(                "<q>"                    "<Q>"                    )
		focus_ind_down=(              "<s>"                    "<p>"                    )
		focus_ind_pgup=(              ""                       ""                       )
		focus_ind_pgdn=(              ""                       ""                       )
		focus_ind_home=(              ""                       ""                       )
		focus_ind_tab=(               "<i>"                    ""                       )
		focus_ind_end=(               ""                       ""                       )
		focus_ind_bs=(                ""                       ""                       )
		focus_ind_del=(               ""                       ""                       )
		focus_ind_space=(             "<space>"                ""                       )
		focus_ind_esc=(               ""                       ""                       )
		focus_ind_enter=(             ""                       ""                       )
		focus_mov_left=(              "<b>"                    "<B>"                    )
		focus_mov_right=(             "<b>"                    "<B>"                    )
		focus_mov_up=(                "<q>"                    "<Q>"                    )
		focus_mov_down=(              "<s>"                    "<p>"                    )
		focus_mov_backward=(          "<r>"                    "<a>"                    )
		focus_mov_forward=(           "<r>"                    "<a>"                    )
		focus_mov_target=(            ""                       ""                       )
		focus_mov_target_next=(       ""                       ""                       )
		focus_mov_target_quick=(      ""                       ""                       )
		focus_mov_quick=(             "<u>"                    ""                       )
		focus_mov_mark=(              ""                       ""                       )
		focus_mov_item=(              ""                       ""                       )
		focus_mov_select=(            ""                       ""                       )
		focus_mov_focus=(             ""                       ""                       )
		focus_mov_focus_prev=(        ""                       ""                       )
		focus_mov_focus_next=(        ""                       ""                       )
		focus_act_prim=(              "<w>"                    "<a-w>"                  )
		focus_act_secon=(             "<n>"                    ""                       )
		focus_act_alt=(               ""                       ""                       )
		focus_act_cut=(               ""                       ""                       )
		focus_act_in=(                ""                       ""                       )
		focus_act_out=(               ""                       ""                       )
		focus_act_edit=(              ""                       ""                       )
		focus_env_new=(               ""                       ""                       )
		focus_env_group=(             ""                       ""                       )
		focus_env_cmd=(               "<a-;>"                  ""                       )
		focus_env_term=(              ""                       ""                       )
		focus_env_undo=(              ""                       ""                       )
		focus_env_re=(                ""                       ""                       )
		focus_env_record=(            ""                       ""                       )
		focus_env_done=(              ""                       ""                       )
		focus_env_code=(              "<g>"                    ""                       )
		focus_env_person=(            "<c>"                    ""                       )
		focus_vie_look=(              ""                       ""                       )
		focus_vie_minus=(             ""                       ""                       )
		focus_vie_plus=(              ""                       ""                       )
		focus_vie_mute=(              ""                       ""                       )


		key_ind_left=(                "left"          "s-left"        )
		key_ind_right=(               "right"         "s-right"       )
		key_ind_up=(                  "up"            "s-up"          )
		key_ind_down=(                "down"          "s-down"        )
		key_ind_pgup=(                "pageup"        "s-pageup"      )
		key_ind_pgdn=(                "pagedown"      "s-pagedown"    )
		key_ind_home=(                "home"          "s-home"        )
		key_ind_end=(                 "end"           "s-end"         )
		key_ind_tab=(                 "tab"           "s-tab"         )
		key_ind_bs=(                  "backspace"     "s-backspace"   )
		key_ind_del=(                 "del"           "s-del"         )
		key_ind_space=(               "space"         "s-space"       )
		key_ind_esc=(                 "esc"           "s-esc"         )
		key_ind_enter=(               "ret"           "s-ret"         )
		key_mov_left=(                "h"             "H"             )
		key_mov_right=(               "k"             "K"             )
		key_mov_up=(                  "u"             "U"             )
		key_mov_down=(                "j"             "J"             )
		key_mov_backward=(            "u"             "U"             )
		key_mov_forward=(             "o"             "O"             )
		key_mov_target=(              "h"             "H"             )
		key_mov_target_next=(         "n"             "N"             )
		key_mov_target_quick=(        "y"             "Y"             )
		key_mov_quick=(               "m"             "M"             )
		key_mov_mark=(                ","             "lt"            )
		key_mov_item=(                "g"             "G"             )
		key_mov_select=(              "s"             "S"             )
		key_mov_focus=(               "a"             "A"             )
		key_mov_focus_prev=(          "["             "{"             )
		key_mov_focus_next=(          "]"             "}"             )
		key_act_prim=(                "d"             "D"             )
		key_act_secon=(               "f"             "F"             )
		key_act_alt=(                 "e"             "E"             )
		key_act_cut=(                 "x"             "X"             )
		key_act_in=(                  "c"             "C"             )
		key_act_out=(                 "v"             "V"             )
		key_act_edit=(                "w"             "W"             )
		key_env_new=(                 "p"             "P"             )
		key_env_group=(               "b"             "B"             )
		key_env_cmd=(                 "semicolon"     ":"             )
		key_env_term=(                "\`"            "~"             )
		key_env_undo=(                "z"             "Z"             )
		key_env_re=(                  "r"             "R"             )
		key_env_record=(              "t"             "T"             )
		key_env_done=(                "."             "gt"            )
		key_env_code=(                "/"             "?"             )
		key_env_person=(              "q"             "Q"             )
		key_vie_look=(                "\\"            "|"             )
		key_vie_minus=(               "minus"         "_"             )
		key_vie_plus=(                "="             "plus"          )
		key_vie_mute=(                "'"             "\""            )


		for key in "${func_list[@]}"
		do
			eval "$(echo "echo \"map global normal <\${key_${key}[0]}> '\${func_${key}[0]}'\"")"
			eval "$(echo "echo \"map global normal <\${key_${key}[1]}> '\${func_${key}[1]}'\"")"
			eval "$(echo "echo \"map global normal <a-\${key_${key}[0]}> '\${func_${key}[2]}'\"")"
			eval "$(echo "echo \"map global normal <a-\${key_${key}[1]}> '\${func_${key}[3]}'\"")"
			[[ ! -z $(eval "$(echo "echo \"\${func_${key}[4]}\"")") ]] && eval "$(echo "echo \"map global normal <c-\${key_${key}[0]}> '\${func_${key}[4]}'\"")"
			[[ ! -z $(eval "$(echo "echo \"\${func_${key}[5]}\"")") ]] && eval "$(echo "echo \"map global normal <c-\${key_${key}[1]}> '\${func_${key}[5]}'\"")"

			eval "$(echo "echo \"map global insert <a-\${key_${key}[0]}> '<a-;>\${func_${key}[0]}'\"")"
			eval "$(echo "echo \"map global insert <a-\${key_${key}[1]}> '<a-;>\${func_${key}[1]}'\"")"

			[[ ! -z $(eval "$(echo "echo \"\${menu_${key}[0]}\"")") ]] && eval "$(echo "echo \"map global Menu <\${key_${key}[0]}> '\${menu_${key}[0]}'\"")" \
			                                                           && eval "$(echo "echo \"map global Menu-ex <\${key_${key}[0]}> '\${menu_${key}[0]}'\"")"
			[[ ! -z $(eval "$(echo "echo \"\${menu_${key}[1]}\"")") ]] && eval "$(echo "echo \"map global Menu <\${key_${key}[1]}> '\${menu_${key}[1]}'\"")" \
			                                                           && eval "$(echo "echo \"map global Menu-ex <\${key_${key}[1]}> '\${menu_${key}[1]}'\"")"
			[[ ! -z $(eval "$(echo "echo \"\${menu_${key}[2]}\"")") ]] && eval "$(echo "echo \"map global Menu <a-\${key_${key}[0]}> '\${menu_${key}[2]}'\"")" \
			                                                           && eval "$(echo "echo \"map global Menu-ex <\${key_${key}[0]}> '\${menu_${key}[2]}'\"")"
			[[ ! -z $(eval "$(echo "echo \"\${menu_${key}[3]}\"")") ]] && eval "$(echo "echo \"map global Menu <a-\${key_${key}[1]}> '\${menu_${key}[3]}'\"")" \
			                                                           && eval "$(echo "echo \"map global Menu-ex <\${key_${key}[1]}> '\${menu_${key}[3]}'\"")"

			[[ ! -z $(eval "$(echo "echo \"\${view_${key}[0]}\"")") ]] && eval "$(echo "echo \"map global View <\${key_${key}[0]}> '\${view_${key}[0]}'\"")"
			[[ ! -z $(eval "$(echo "echo \"\${view_${key}[1]}\"")") ]] && eval "$(echo "echo \"map global View <\${key_${key}[1]}> '\${view_${key}[1]}'\"")"

			[[ ! -z $(eval "$(echo "echo \"\${focus_${key}[0]}\"")") ]] && eval "$(echo "echo \"map global Focus <\${key_${key}[0]}> '<a-i>\${focus_${key}[0]}'\"")" \
			                                                            && eval "$(echo "echo \"map global Focus-begin <\${key_${key}[0]}> '<a-[>\${focus_${key}[0]}'\"")" \
			                                                            && eval "$(echo "echo \"map global Focus-end <\${key_${key}[0]}> '<a-]>\${focus_${key}[0]}'\"")" \
			                                                            && eval "$(echo "echo \"map global Focus-begin-ex <\${key_${key}[0]}> '<a-{>\${focus_${key}[0]}'\"")" \
			                                                            && eval "$(echo "echo \"map global Focus-end-ex <\${key_${key}[0]}> '<a-}>\${focus_${key}[0]}'\"")"
			[[ ! -z $(eval "$(echo "echo \"\${focus_${key}[1]}\"")") ]] && eval "$(echo "echo \"map global FOCUS <\${key_${key}[1]}> '<a-a>\${focus_${key}[1]}'\"")" \
			                                                            && eval "$(echo "echo \"map global FOCUS-begin <\${key_${key}[1]}> '<[>\${focus_${key}[1]}'\"")" \
			                                                            && eval "$(echo "echo \"map global FOCUS-end <\${key_${key}[1]}> '<]>\${focus_${key}[1]}'\"")" \
			                                                            && eval "$(echo "echo \"map global FOCUS-begin-ex <\${key_${key}[1]}> '<{>\${focus_${key}[1]}'\"")" \
			                                                            && eval "$(echo "echo \"map global FOCUS-end-ex <\${key_${key}[1]}> '<}>\${focus_${key}[1]}'\"")"
		done
	}
}

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
	declare-user-mode Menu           ; define-command -hidden bkey-menu         'enter-user-mode Menu'
	declare-user-mode MenuEx         ; define-command -hidden bkey-menuex       'enter-user-mode MenuEx'
	declare-user-mode View           ; define-command -hidden bkey-view         'enter-user-mode View'
	                                   define-command -hidden bkey-view-lock    'enter-user-mode -lock View'

	# Movement
	define-command -hidden bkey-to-line %{
		evaluate-commands %sh{
			if [ $kak_count -gt '0' ]; then
				[ $1 != 'e' ] && ex='<;>'
				echo "execute-keys $ex<G><g>$kak_count<J><k>"
			fi
		}

		execute-keys <V><c><m><esc>
	}

	# Action
	#TODO fix paste
	define-command -hidden -params 1 bkey-ins %{
		execute-keys -with-hooks %sh{
			[ -n $kak_register ] && register="<\><$kak_register>"
			[ $kak_count -gt '0' ] && paste_keys="<;>$(( $kak_count - 1 ))"
			select_pos_1=${kak_selection_desc%%,*}
			select_pos_2=${kak_selection_desc##*,}

			if [ ${select_pos_1%%.*} -lt ${select_pos_2%%.*} ]; then
				cursor_pos='a'
			elif [ ${select_pos_1%%.*} = ${select_pos_2%%.*} ]; then
				[ ${select_pos_1##*.} -lt ${select_pos_2##*.} ] && cursor_pos='a'
				[ ${select_pos_1##*.} = ${select_pos_2##*.}  ] && cursor_pos='1'
			fi

			case $cursor_pos in
				'a')
					case $1 in
						'i')   echo '<a>'                            ;;
						'p')   echo "$kak_count$register<p>"         ;;
						'pa')  echo "$kak_count$register<a-p>"       ;;
						'pe')  echo "$kak_count$register<p>"         ;;
						'pea') echo "$kak_count$register<a-p>"       ;;
						'c')   echo '<a-!>'                          ;;
					esac
				;;
				'1')
					case $1 in
						'i')   echo '<i>'                            ;;
						'p')   echo "$kak_count$register<P>"         ;;
						'pa')  echo "$kak_count$register<a-P>"       ;;
						'pe')  echo "<h>$kak_count$register<p><l>"   ;;
						'pea') echo "<h>$kak_count$register<a-p><l>" ;;
						'c')   echo '<!>'                            ;;
					esac
				;;
				'i'|*)
					case $1 in
						'i')   echo '<i>'                            ;;
						'p')   echo "$kak_count$register<P>"         ;;
						'pa')  echo "$kak_count$register<a-P>"       ;;
						'pe')  echo "$kak_count$register<P>"         ;;
						'pea') echo "$kak_count$register<a-P>"       ;;
						'c')   echo '<!>'                            ;;
					esac
				;;
			esac
		}
	}

	define-command -hidden bkey-open-term 'terminal %val{client_env_SHELL}'

	hook global InsertCompletionShow .* %{ map   window insert <tab> '<c-n>'; map   window insert <s-tab> '<c-p>' }
	hook global InsertCompletionHide .* %{ unmap window insert <tab> '<c-n>'; unmap window insert <s-tab> '<c-p>' }

# Mapping
#TODO map global object  <t>  %{c<lt>([\w.]+)\b[^>]*?(?<lt>!/)>,<lt>/([\w.]+)\b[^>]*?(?<lt>!/)><ret>}  -docstring 'xml tag object'
#TODO <a-z>
define-command bkey-make %{ source bkey-load.kak }

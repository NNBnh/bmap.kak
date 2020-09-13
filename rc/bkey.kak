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
	# Movement
	define-command -hidden bkey-line %{
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
			[ -n "$kak_register" ] && register="<\><$kak_register>"
			selection_1_pos=${kak_selection_desc%%,*}
			selection_1_lin=${selection_1_pos%%.*}
			selection_1_col=${selection_1_pos##*.}
			selection_2_pos=${kak_selection_desc##*,}
			selection_2_lin=${selection_2_pos%%.*}
			selection_2_col=${selection_2_pos##*.}

			if [ $selection_1_lin -lt $selection_2_lin ]; then
				cursor_pos='a'
			elif [ $selection_1_lin = $selection_2_lin ]; then
				if [ $selection_1_col -lt $selection_2_col ]; then
					cursor_pos='a'
				elif [ $selection_1_col = $selection_2_col  ]; then
					cursor_pos='1'
				fi
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

	define-command -hidden bkey-term 'terminal %val{client_env_SHELL}'


# Mapping
map global object <t> %{c<lt>([\w.]+)\b[^>]*?(?<lt>!/)>,<lt>/([\w.]+)\b[^>]*?(?<lt>!/)><ret>}  -docstring 'xml tag object'


define-command -params 0..2 bkey %{
	evaluate-commands %sh{
		mode=${1:-'normal'}
		flag=${2:-'0'}
		keys="
			ops____________0
			ops____________1
			ops____________2
			ops____________3
			ops____________4
			ops____________5
			ops____________6
			ops____________7
			ops____________8
			ops____________9
			cua___________f1
			cua___________f2
			cua___________f3
			cua___________f4
			cua___________f5
			cua___________f6
			cua___________f7
			cua___________f8
			cua___________f9
			cua__________f10
			cua__________f11
			cua__________f12
			cua_________left
			cua________right
			cua___________up
			cua_________down
			cua_______pageup
			cua_____pagedown
			cua_________home
			cua__________end
			cua________cycle
			cua____backspace
			cua_______delete
			cua______advance
			cua_________exit
			cua________enter
			nav_________left
			nav________right
			nav___________up
			nav_________down
			nav_____backward
			nav______forward
			nav________taget
			nav________cycle
			nav________local
			nav________quick
			nav_________load
			nav_________item
			nav________focus
			nav_______select
			nav_________next
			nav_________prev
			act______primary
			act____secondary
			act__alternative
			act__________cut
			act___________in
			act__________out
			env_________edit
			env__________new
			env________group
			env______command
			env_____terminal
			env______history
			env___________re
			env_______record
			env_________done
			env_________code
			env_______person
			vie_________view
			vie________minus
			vie_________plus
			vie________equal
		"

		for key in $keys; do
			case $key in
				'ops____________0') key___="<0>"                             ; key__s="<)>"                             ; key_a_="<a-0>"                           ; key_as="<a-)>"                           ; key_c_=""                                ; key_cs=""                                ;;
				'ops____________1') key___="<1>"                             ; key__s="<!>"                             ; key_a_="<a-1>"                           ; key_as="<a-!>"                           ; key_c_=""                                ; key_cs=""                                ;;
				'ops____________2') key___="<2>"                             ; key__s="<@>"                             ; key_a_="<a-2>"                           ; key_as="<a-@>"                           ; key_c_=""                                ; key_cs=""                                ;;
				'ops____________3') key___="<3>"                             ; key__s="<#>"                             ; key_a_="<a-3>"                           ; key_as="<a-#>"                           ; key_c_=""                                ; key_cs=""                                ;;
				'ops____________4') key___="<4>"                             ; key__s="<$>"                             ; key_a_="<a-4>"                           ; key_as="<a-$>"                           ; key_c_=""                                ; key_cs=""                                ;;
				'ops____________5') key___="<5>"                             ; key__s="<%%%%>"                          ; key_a_="<a-5>"                           ; key_as="<a-%%%%>"                        ; key_c_=""                                ; key_cs=""                                ;;
				'ops____________6') key___="<6>"                             ; key__s="<^>"                             ; key_a_="<a-6>"                           ; key_as="<a-^>"                           ; key_c_=""                                ; key_cs=""                                ;;
				'ops____________7') key___="<7>"                             ; key__s="<&>"                             ; key_a_="<a-7>"                           ; key_as="<a-&>"                           ; key_c_=""                                ; key_cs=""                                ;;
				'ops____________8') key___="<8>"                             ; key__s="<*>"                             ; key_a_="<a-8>"                           ; key_as="<a-*>"                           ; key_c_=""                                ; key_cs=""                                ;;
				'ops____________9') key___="<9>"                             ; key__s="<(>"                             ; key_a_="<a-9>"                           ; key_as="<a-(>"                           ; key_c_=""                                ; key_cs=""                                ;;
				'cua___________f1') key___="<F1>"                            ; key__s=""                                ; key_a_=""                                ; key_as=""                                ; key_c_=""                                ; key_cs=""                                ;;
				'cua___________f2') key___="<F2>"                            ; key__s=""                                ; key_a_=""                                ; key_as=""                                ; key_c_=""                                ; key_cs=""                                ;;
				'cua___________f3') key___="<F3>"                            ; key__s=""                                ; key_a_=""                                ; key_as=""                                ; key_c_=""                                ; key_cs=""                                ;;
				'cua___________f4') key___="<F4>"                            ; key__s=""                                ; key_a_=""                                ; key_as=""                                ; key_c_=""                                ; key_cs=""                                ;;
				'cua___________f5') key___="<F5>"                            ; key__s=""                                ; key_a_=""                                ; key_as=""                                ; key_c_=""                                ; key_cs=""                                ;;
				'cua___________f6') key___="<F6>"                            ; key__s=""                                ; key_a_=""                                ; key_as=""                                ; key_c_=""                                ; key_cs=""                                ;;
				'cua___________f7') key___="<F7>"                            ; key__s=""                                ; key_a_=""                                ; key_as=""                                ; key_c_=""                                ; key_cs=""                                ;;
				'cua___________f8') key___="<F8>"                            ; key__s=""                                ; key_a_=""                                ; key_as=""                                ; key_c_=""                                ; key_cs=""                                ;;
				'cua___________f9') key___="<F9>"                            ; key__s=""                                ; key_a_=""                                ; key_as=""                                ; key_c_=""                                ; key_cs=""                                ;;
				'cua__________f10') key___="<F10>"                           ; key__s=""                                ; key_a_=""                                ; key_as=""                                ; key_c_=""                                ; key_cs=""                                ;;
				'cua__________f11') key___="<F11>"                           ; key__s=""                                ; key_a_=""                                ; key_as=""                                ; key_c_=""                                ; key_cs=""                                ;;
				'cua__________f12') key___="<F12>"                           ; key__s=""                                ; key_a_=""                                ; key_as=""                                ; key_c_=""                                ; key_cs=""                                ;;
				'cua_________left') key___="<left>"                          ; key__s="<s-left>"                        ; key_a_="<a-left>"                        ; key_as="<a-s-left>"                      ; key_c_="<c-left>"                        ; key_cs="<c-s-left>"                      ;;
				'cua________right') key___="<right>"                         ; key__s="<s-right>"                       ; key_a_="<a-right>"                       ; key_as="<a-s-right>"                     ; key_c_="<c-right>"                       ; key_cs="<c-s-right>"                     ;;
				'cua___________up') key___="<up>"                            ; key__s="<s-up>"                          ; key_a_="<a-up>"                          ; key_as="<a-s-up>"                        ; key_c_="<c-up>"                          ; key_cs="<c-s-up>"                        ;;
				'cua_________down') key___="<down>"                          ; key__s="<s-down>"                        ; key_a_="<a-down>"                        ; key_as="<a-s-down>"                      ; key_c_="<c-down>"                        ; key_cs="<c-s-down>"                      ;;
				'cua_______pageup') key___="<pageup>"                        ; key__s="<s-pageup>"                      ; key_a_="<a-pageup>"                      ; key_as="<a-s-pageup>"                    ; key_c_="<c-pageup>"                      ; key_cs="<c-s-pageup>"                    ;;
				'cua_____pagedown') key___="<pagedown>"                      ; key__s="<s-pagedown>"                    ; key_a_="<a-pagedown>"                    ; key_as="<a-s-pagedown>"                  ; key_c_="<c-pagedown>"                    ; key_cs="<c-s-pagedown>"                  ;;
				'cua_________home') key___="<home>"                          ; key__s="<s-home>"                        ; key_a_="<a-home>"                        ; key_as="<a-s-home>"                      ; key_c_="<c-home>"                        ; key_cs="<c-s-home>"                      ;;
				'cua__________end') key___="<end>"                           ; key__s="<s-end>"                         ; key_a_="<a-end>"                         ; key_as="<a-s-end>"                       ; key_c_="<c-end>"                         ; key_cs="<c-s-end>"                       ;;
				'cua________cycle') key___="<tab>"                           ; key__s="<s-tab>"                         ; key_a_="<a-tab>"                         ; key_as="<a-s-tab>"                       ; key_c_=""                                ; key_cs=""                                ;;
				'cua____backspace') key___="<backspace>"                     ; key__s=""                                ; key_a_=""                                ; key_as=""                                ; key_c_=""                                ; key_cs=""                                ;;
				'cua_______delete') key___="<del>"                           ; key__s=""                                ; key_a_=""                                ; key_as=""                                ; key_c_=""                                ; key_cs=""                                ;;
				'cua______advance') key___="<space>"                         ; key__s=""                                ; key_a_="<a-space>"                       ; key_as=""                                ; key_c_="<c-space>"                       ; key_cs=""                                ;;
				'cua_________exit') key___="<esc>"                           ; key__s=""                                ; key_a_=""                                ; key_as=""                                ; key_c_=""                                ; key_cs=""                                ;;
				'cua________enter') key___="<ret>"                           ; key__s=""                                ; key_a_=""                                ; key_as=""                                ; key_c_=""                                ; key_cs=""                                ;;
				'nav_________left') key___="<j>"                             ; key__s="<J>"                             ; key_a_="<a-j>"                           ; key_as="<a-J>"                           ; key_c_=""                                ; key_cs=""                                ;;
				'nav________right') key___="<l>"                             ; key__s="<L>"                             ; key_a_="<a-l>"                           ; key_as="<a-L>"                           ; key_c_="<c-l>"                           ; key_cs=""                                ;;
				'nav___________up') key___="<i>"                             ; key__s="<I>"                             ; key_a_="<a-i>"                           ; key_as="<a-I>"                           ; key_c_=""                                ; key_cs=""                                ;;
				'nav_________down') key___="<k>"                             ; key__s="<K>"                             ; key_a_="<a-k>"                           ; key_as="<a-K>"                           ; key_c_="<c-k>"                           ; key_cs=""                                ;;
				'nav_____backward') key___="<u>"                             ; key__s="<U>"                             ; key_a_="<a-u>"                           ; key_as="<a-U>"                           ; key_c_="<c-u>"                           ; key_cs=""                                ;;
				'nav______forward') key___="<o>"                             ; key__s="<O>"                             ; key_a_="<a-o>"                           ; key_as="<a-O>"                           ; key_c_="<c-o>"                           ; key_cs=""                                ;;
				'nav________taget') key___="<h>"                             ; key__s="<H>"                             ; key_a_="<a-h>"                           ; key_as="<a-H>"                           ; key_c_=""                                ; key_cs=""                                ;;
				'nav________cycle') key___="<n>"                             ; key__s="<N>"                             ; key_a_="<a-n>"                           ; key_as="<a-N>"                           ; key_c_="<c-n>"                           ; key_cs=""                                ;;
				'nav________local') key___="<y>"                             ; key__s="<Y>"                             ; key_a_="<a-y>"                           ; key_as="<a-Y>"                           ; key_c_="<c-y>"                           ; key_cs=""                                ;;
				'nav________quick') key___="<m>"                             ; key__s="<M>"                             ; key_a_="<a-m>"                           ; key_as="<a-M>"                           ; key_c_=""                                ; key_cs=""                                ;;
				'nav_________load') key___="<,>"                             ; key__s="<lt>"                            ; key_a_="<a-,>"                           ; key_as="<a-lt>"                          ; key_c_=""                                ; key_cs=""                                ;;
				'nav_________item') key___="<g>"                             ; key__s="<G>"                             ; key_a_="<a-g>"                           ; key_as="<a-G>"                           ; key_c_="<c-g>"                           ; key_cs=""                                ;;
				'nav________focus') key___="<s>"                             ; key__s="<S>"                             ; key_a_="<a-s>"                           ; key_as="<a-S>"                           ; key_c_="<c-s>"                           ; key_cs=""                                ;;
				'nav_______select') key___="<a>"                             ; key__s="<A>"                             ; key_a_="<a-a>"                           ; key_as="<a-A>"                           ; key_c_="<c-a>"                           ; key_cs=""                                ;;
				'nav_________next') key___="<[>"                             ; key__s="<{>"                             ; key_a_="<a-[>"                           ; key_as="<a-{>"                           ; key_c_=""                                ; key_cs=""                                ;;
				'nav_________prev') key___="<]>"                             ; key__s="<}>"                             ; key_a_="<a-]>"                           ; key_as="<a-}>"                           ; key_c_=""                                ; key_cs=""                                ;;
				'act______primary') key___="<d>"                             ; key__s="<D>"                             ; key_a_="<a-d>"                           ; key_as="<a-D>"                           ; key_c_="<c-d>"                           ; key_cs=""                                ;;
				'act____secondary') key___="<f>"                             ; key__s="<F>"                             ; key_a_="<a-f>"                           ; key_as="<a-F>"                           ; key_c_="<c-f>"                           ; key_cs=""                                ;;
				'act__alternative') key___="<e>"                             ; key__s="<E>"                             ; key_a_="<a-e>"                           ; key_as="<a-E>"                           ; key_c_="<c-e>"                           ; key_cs=""                                ;;
				'act__________cut') key___="<x>"                             ; key__s="<X>"                             ; key_a_="<a-x>"                           ; key_as="<a-X>"                           ; key_c_="<c-x>"                           ; key_cs=""                                ;;
				'act___________in') key___="<c>"                             ; key__s="<C>"                             ; key_a_="<a-c>"                           ; key_as="<a-C>"                           ; key_c_="<c-c>"                           ; key_cs=""                                ;;
				'act__________out') key___="<v>"                             ; key__s="<V>"                             ; key_a_="<a-v>"                           ; key_as="<a-V>"                           ; key_c_="<c-v>"                           ; key_cs=""                                ;;
				'env_________edit') key___="<w>"                             ; key__s="<W>"                             ; key_a_="<a-w>"                           ; key_as="<a-W>"                           ; key_c_="<c-w>"                           ; key_cs=""                                ;;
				'env__________new') key___="<p>"                             ; key__s="<P>"                             ; key_a_="<a-p>"                           ; key_as="<a-P>"                           ; key_c_="<c-p>"                           ; key_cs=""                                ;;
				'env________group') key___="<b>"                             ; key__s="<B>"                             ; key_a_="<a-b>"                           ; key_as="<a-B>"                           ; key_c_="<c-b>"                           ; key_cs=""                                ;;
				'env______command') key___="<semicolon>"                     ; key__s="<:>"                             ; key_a_="<a-semicolon>"                   ; key_as="<a-:>"                           ; key_c_=""                                ; key_cs=""                                ;;
				'env_____terminal') key___="<\`>"                            ; key__s="<~>"                             ; key_a_="<a-\`>"                          ; key_as="<a-~>"                           ; key_c_=""                                ; key_cs=""                                ;;
				'env______history') key___="<z>"                             ; key__s="<Z>"                             ; key_a_="<a-z>"                           ; key_as="<a-Z>"                           ; key_c_="<c-z>"                           ; key_cs=""                                ;;
				'env___________re') key___="<r>"                             ; key__s="<R>"                             ; key_a_="<a-r>"                           ; key_as="<a-R>"                           ; key_c_="<c-r>"                           ; key_cs=""                                ;;
				'env_______record') key___="<t>"                             ; key__s="<T>"                             ; key_a_="<a-t>"                           ; key_as="<a-T>"                           ; key_c_="<c-t>"                           ; key_cs=""                                ;;
				'env_________done') key___="<.>"                             ; key__s="<gt>"                            ; key_a_="<a-.>"                           ; key_as="<a-gt>"                          ; key_c_=""                                ; key_cs=""                                ;;
				'env_________code') key___="</>"                             ; key__s="<?>"                             ; key_a_="<a-/>"                           ; key_as="<a-?>"                           ; key_c_=""                                ; key_cs=""                                ;;
				'env_______person') key___="<q>"                             ; key__s="<Q>"                             ; key_a_="<a-q>"                           ; key_as="<a-Q>"                           ; key_c_="<c-q>"                           ; key_cs=""                                ;;
				'vie_________view') key___="<\\>"                            ; key__s="<|>"                             ; key_a_="<a-\\>"                          ; key_as="<a-|>"                           ; key_c_=""                                ; key_cs=""                                ;;
				'vie________minus') key___="<minus>"                         ; key__s="<_>"                             ; key_a_="<a-minus>"                       ; key_as="<a-_>"                           ; key_c_=""                                ; key_cs=""                                ;;
				'vie_________plus') key___="<=>"                             ; key__s="<plus>"                          ; key_a_="<a-=>"                           ; key_as="<a-plus>"                        ; key_c_=""                                ; key_cs=""                                ;;
				'vie________equal') key___="<'>"                             ; key__s="<\"\">"                          ; key_a_="<a-'>"                           ; key_as="<a-\"\">"                        ; key_c_=""                                ; key_cs=""                                ;;
			esac

			case $key in
				'ops____________0') nor___="<0>"                             ; nor__s=""                                ; nor_a_=""                                ; nor_as=""                                ; nor_c_=""                                ; nor_cs=""                                ;;
				'ops____________1') nor___="<1>"                             ; nor__s=""                                ; nor_a_=""                                ; nor_as=""                                ; nor_c_=""                                ; nor_cs=""                                ;;
				'ops____________2') nor___="<2>"                             ; nor__s=""                                ; nor_a_=""                                ; nor_as=""                                ; nor_c_=""                                ; nor_cs=""                                ;;
				'ops____________3') nor___="<3>"                             ; nor__s=""                                ; nor_a_=""                                ; nor_as=""                                ; nor_c_=""                                ; nor_cs=""                                ;;
				'ops____________4') nor___="<4>"                             ; nor__s=""                                ; nor_a_=""                                ; nor_as=""                                ; nor_c_=""                                ; nor_cs=""                                ;;
				'ops____________5') nor___="<5>"                             ; nor__s=""                                ; nor_a_=""                                ; nor_as=""                                ; nor_c_=""                                ; nor_cs=""                                ;;
				'ops____________6') nor___="<6>"                             ; nor__s=""                                ; nor_a_=""                                ; nor_as=""                                ; nor_c_=""                                ; nor_cs=""                                ;;
				'ops____________7') nor___="<7>"                             ; nor__s=""                                ; nor_a_=""                                ; nor_as=""                                ; nor_c_=""                                ; nor_cs=""                                ;;
				'ops____________8') nor___="<8>"                             ; nor__s=""                                ; nor_a_=""                                ; nor_as=""                                ; nor_c_=""                                ; nor_cs=""                                ;;
				'ops____________9') nor___="<9>"                             ; nor__s=""                                ; nor_a_=""                                ; nor_as=""                                ; nor_c_=""                                ; nor_cs=""                                ;;
				'cua___________f1') nor___=""                                ; nor__s=""                                ; nor_a_=""                                ; nor_as=""                                ; nor_c_=""                                ; nor_cs=""                                ;;
				'cua___________f2') nor___=""                                ; nor__s=""                                ; nor_a_=""                                ; nor_as=""                                ; nor_c_=""                                ; nor_cs=""                                ;;
				'cua___________f3') nor___=""                                ; nor__s=""                                ; nor_a_=""                                ; nor_as=""                                ; nor_c_=""                                ; nor_cs=""                                ;;
				'cua___________f4') nor___=""                                ; nor__s=""                                ; nor_a_=""                                ; nor_as=""                                ; nor_c_=""                                ; nor_cs=""                                ;;
				'cua___________f5') nor___=""                                ; nor__s=""                                ; nor_a_=""                                ; nor_as=""                                ; nor_c_=""                                ; nor_cs=""                                ;;
				'cua___________f6') nor___=""                                ; nor__s=""                                ; nor_a_=""                                ; nor_as=""                                ; nor_c_=""                                ; nor_cs=""                                ;;
				'cua___________f7') nor___=""                                ; nor__s=""                                ; nor_a_=""                                ; nor_as=""                                ; nor_c_=""                                ; nor_cs=""                                ;;
				'cua___________f8') nor___=""                                ; nor__s=""                                ; nor_a_=""                                ; nor_as=""                                ; nor_c_=""                                ; nor_cs=""                                ;;
				'cua___________f9') nor___=""                                ; nor__s=""                                ; nor_a_=""                                ; nor_as=""                                ; nor_c_=""                                ; nor_cs=""                                ;;
				'cua__________f10') nor___=""                                ; nor__s=""                                ; nor_a_=""                                ; nor_as=""                                ; nor_c_=""                                ; nor_cs=""                                ;;
				'cua__________f11') nor___=""                                ; nor__s=""                                ; nor_a_=""                                ; nor_as=""                                ; nor_c_=""                                ; nor_cs=""                                ;;
				'cua__________f12') nor___=""                                ; nor__s=""                                ; nor_a_=""                                ; nor_as=""                                ; nor_c_=""                                ; nor_cs=""                                ;;
				'cua_________left') nor___="<h>"                             ; nor__s="<H>"                             ; nor_a_="<lt>"                            ; nor_as="<a-lt>"                          ; nor_c_="<b>"                             ; nor_cs="<B>"                             ;;
				'cua________right') nor___="<l>"                             ; nor__s="<L>"                             ; nor_a_="<gt>"                            ; nor_as="<a-gt>"                          ; nor_c_="<e>"                             ; nor_cs="<E>"                             ;;
				'cua___________up') nor___="<k>"                             ; nor__s="<K>"                             ; nor_a_=""                                ; nor_as=""                                ; nor_c_="<k>"                             ; nor_cs="<K>"                             ;;
				'cua_________down') nor___="<j>"                             ; nor__s="<J>"                             ; nor_a_=""                                ; nor_as=""                                ; nor_c_="<j>"                             ; nor_cs="<J>"                             ;;
				'cua_______pageup') nor___="<c-b>"                           ; nor__s="<c-b>"                           ; nor_a_=""                                ; nor_as=""                                ; nor_c_="<c-u>"                           ; nor_cs="<c-u>"                           ;;
				'cua_____pagedown') nor___="<c-f>"                           ; nor__s="<c-f>"                           ; nor_a_=""                                ; nor_as=""                                ; nor_c_="<c-d>"                           ; nor_cs="<c-d>"                           ;;
				'cua_________home') nor___="<a-h>"                           ; nor__s="<a-H>"                           ; nor_a_=""                                ; nor_as=""                                ; nor_c_="<g><g>"                          ; nor_cs="<G><g>"                          ;;
				'cua__________end') nor___="<a-l>"                           ; nor__s="<a-L>"                           ; nor_a_=""                                ; nor_as=""                                ; nor_c_="<g><e>"                          ; nor_cs="<G><e>"                          ;;
				'cua________cycle') nor___=": buffer-previous<ret>"          ; nor__s=": buffer-next<ret>"              ; nor_a_=""                                ; nor_as=""                                ; nor_c_=""                                ; nor_cs=""                                ;;
				'cua____backspace') nor___="<;><h><a-d>"                     ; nor__s=""                                ; nor_a_=""                                ; nor_as=""                                ; nor_c_=""                                ; nor_cs=""                                ;;
				'cua_______delete') nor___="<;><a-d>"                        ; nor__s=""                                ; nor_a_=""                                ; nor_as=""                                ; nor_c_=""                                ; nor_cs=""                                ;;
				'cua______advance') nor___=": bkey menu %%val{count}<ret>"   ; nor__s=""                                ; nor_a_=": bkey menu %%val{count}<ret>"   ; nor_as=""                                ; nor_c_=""                                ; nor_cs=""                                ;;
				'cua_________exit') nor___="<;>"                             ; nor__s=""                                ; nor_a_=""                                ; nor_as=""                                ; nor_c_=""                                ; nor_cs=""                                ;;
				'cua________enter') nor___="<ret>"                           ; nor__s=""                                ; nor_a_=""                                ; nor_as=""                                ; nor_c_=""                                ; nor_cs=""                                ;;
				'nav_________left') nor___="<h>"                             ; nor__s="<a-h>"                           ; nor_a_="<H>"                             ; nor_as="<a-H>"                           ; nor_c_=""                                ; nor_cs=""                                ;;
				'nav________right') nor___="<l>"                             ; nor__s="<a-l>"                           ; nor_a_="<L>"                             ; nor_as="<a-L>"                           ; nor_c_=""                                ; nor_cs=""                                ;;
				'nav___________up') nor___="<k>"                             ; nor__s="<[>p"                            ; nor_a_="<K>"                             ; nor_as="<{>p"                            ; nor_c_=""                                ; nor_cs=""                                ;;
				'nav_________down') nor___="<j>"                             ; nor__s="<]>p"                            ; nor_a_="<J>"                             ; nor_as="<}>p"                            ; nor_c_=""                                ; nor_cs=""                                ;;
				'nav_____backward') nor___="<b>"                             ; nor__s="<a-b>"                           ; nor_a_="<B>"                             ; nor_as="<a-B>"                           ; nor_c_=""                                ; nor_cs=""                                ;;
				'nav______forward') nor___="<e>"                             ; nor__s="<a-e>"                           ; nor_a_="<E>"                             ; nor_as="<a-E>"                           ; nor_c_=":edit "                          ; nor_cs=""                                ;;
				'nav________taget') nor___="</>"                             ; nor__s="<a-/>"                           ; nor_a_="<?>"                             ; nor_as="<a-?>"                           ; nor_c_=""                                ; nor_cs=""                                ;;
				'nav________cycle') nor___="<n>"                             ; nor__s="<a-n>"                           ; nor_a_="<N>"                             ; nor_as="<a-N>"                           ; nor_c_=""                                ; nor_cs=""                                ;;
				'nav________local') nor___="<f>"                             ; nor__s="<a-f>"                           ; nor_a_="<F>"                             ; nor_as="<a-F>"                           ; nor_c_="<U>"                             ; nor_cs=""                                ;;
				'nav________quick') nor___="<m>"                             ; nor__s="<a-m>"                           ; nor_a_="<M>"                             ; nor_as="<a-M>"                           ; nor_c_=""                                ; nor_cs=""                                ;;
				'nav_________load') nor___="<z>"                             ; nor__s="<Z>"                             ; nor_a_=""                                ; nor_as="<c-s>"                           ; nor_c_=""                                ; nor_cs=""                                ;;
				'nav_________item') nor___="<)>"                             ; nor__s="<(>"                             ; nor_a_="<a-)>"                           ; nor_as="<a-(>"                           ; nor_c_=": bkey-line<ret>"                ; nor_cs=""                                ;;
				'nav________focus') nor___="<a-x>"                           ; nor__s="<%%%%>"                          ; nor_a_="<a-x>"                           ; nor_as="<a-X>"                           ; nor_c_=": write<ret>"                    ; nor_cs=":write "                         ;;
				'nav_______select') nor___="<a-i>"                           ; nor__s="<a-a>"                           ; nor_a_="<a-;>"                           ; nor_as="<a-:>"                           ; nor_c_="<%%%%>"                          ; nor_cs=""                                ;;
				'nav_________next') nor___="<a-[>"                           ; nor__s="["                               ; nor_a_="<a-{>"                           ; nor_as="{"                               ; nor_c_=""                                ; nor_cs=""                                ;;
				'nav_________prev') nor___="<a-]>"                           ; nor__s="]"                               ; nor_a_="<a-}>"                           ; nor_as="}"                               ; nor_c_=""                                ; nor_cs=""                                ;;
				'act______primary') nor___=": bkey-ins i<ret>"               ; nor__s="<A>"                             ; nor_a_=": bkey-ins i<ret>"               ; nor_as="<I>"                             ; nor_c_=""                                ; nor_cs=""                                ;;
				'act____secondary') nor___="<u>"                             ; nor__s="<U>"                             ; nor_a_="<c-o>"                           ; nor_as="<c-i>"                           ; nor_c_="</>"                             ; nor_cs=""                                ;;
				'act__alternative') nor___="<a-c>"                           ; nor__s="<a-l><a-c>"                      ; nor_a_="<r>"                             ; nor_as=""                                ; nor_c_=""                                ; nor_cs=""                                ;;
				'act__________cut') nor___="<d>"                             ; nor__s="<a-l><d>"                        ; nor_a_="<a-d>"                           ; nor_as="<a-l><a-d>"                      ; nor_c_="<d>"                             ; nor_cs=""                                ;;
				'act___________in') nor___="<y>"                             ; nor__s="<a-l><y>"                        ; nor_a_="<y>"                             ; nor_as="<a-L><y>"                        ; nor_c_="<y>"                             ; nor_cs=""                                ;;
				'act__________out') nor___=": bkey-ins p<ret>"               ; nor__s="<R>"                             ; nor_a_=": bkey-ins pe<ret>"              ; nor_as="<R>"                             ; nor_c_=": bkey-ins p<ret>"               ; nor_cs=""                                ;;
				'env_________edit') nor___="<space>"                         ; nor__s="<a-space>"                       ; nor_a_="<_>"                             ; nor_as=""                                ; nor_c_=": delete-buffer<ret>"            ; nor_cs=""                                ;;
				'env__________new') nor___="<a-o>"                           ; nor__s="<a-O>"                           ; nor_a_="<C>"                             ; nor_as="<a-C>"                           ; nor_c_=""                                ; nor_cs=""                                ;;
				'env________group') nor___="<a-J>"                           ; nor__s="<a-_>"                           ; nor_a_="<a-j>"                           ; nor_as=""                                ; nor_c_=""                                ; nor_cs=""                                ;;
				'env______command') nor___="<:>"                             ; nor__s=": bkey-ins c<ret>"               ; nor_a_="<a-|>"                           ; nor_as="<|>"                             ; nor_c_=""                                ; nor_cs=""                                ;;
				'env_____terminal') nor___=":terminal "                      ; nor__s=": bkey-term<ret>"                ; nor_a_="<a-|>"                           ; nor_as="<|>"                             ; nor_c_=""                                ; nor_cs=""                                ;;
				'env______history') nor___="<u>"                             ; nor__s="<U>"                             ; nor_a_="<a-u>"                           ; nor_as="<a-U>"                           ; nor_c_="<u>"                             ; nor_cs="<U>"                             ;;
				'env___________re') nor___="<a-.>"                           ; nor__s="<.>"                             ; nor_a_=""                                ; nor_as=""                                ; nor_c_="<V><c><m><esc>"                  ; nor_cs=""                                ;;
				'env_______record') nor___="<q>"                             ; nor__s="<Q>"                             ; nor_a_=""                                ; nor_as="<esc>"                           ; nor_c_=""                                ; nor_cs=""                                ;;
				'env_________done') nor___=": write<ret>"                    ; nor__s=": write-all<ret>"                ; nor_a_=""                                ; nor_as=""                                ; nor_c_=""                                ; nor_cs=""                                ;;
				'env_________code') nor___="<\"\">"                          ; nor__s="<\\>"                            ; nor_a_=": comment-line<ret>"             ; nor_as=": comment-block<ret>"            ; nor_c_=""                                ; nor_cs=""                                ;;
				'env_______person') nor___="<,>"                             ; nor__s=""                                ; nor_a_=""                                ; nor_as=""                                ; nor_c_=": quit<ret>"                     ; nor_cs=""                                ;;
				'vie_________view') nor___=": bkey view<ret>"                ; nor__s=""                                ; nor_a_=""                                ; nor_as=""                                ; nor_c_=""                                ; nor_cs=""                                ;;
				'vie________minus') nor___="<lt>"                            ; nor__s="<\`>"                            ; nor_a_="<a-lt>"                          ; nor_as=""                                ; nor_c_=""                                ; nor_cs=""                                ;;
				'vie_________plus') nor___="<gt>"                            ; nor__s="<~>"                             ; nor_a_="<a-gt>"                          ; nor_as=""                                ; nor_c_=""                                ; nor_cs=""                                ;;
				'vie________equal') nor___="<&>"                             ; nor__s="<a-\`>"                          ; nor_a_="<a-&>"                           ; nor_as=""                                ; nor_c_=""                                ; nor_cs=""                                ;;
			esac

			case $key in
				'ops____________0') ins___=""                                ; ins__s=""                                ; ins_a_=""                                ;ins_as=""                                 ;;
				'ops____________1') ins___=""                                ; ins__s=""                                ; ins_a_=""                                ;ins_as=""                                 ;;
				'ops____________2') ins___=""                                ; ins__s=""                                ; ins_a_=""                                ;ins_as=""                                 ;;
				'ops____________3') ins___=""                                ; ins__s=""                                ; ins_a_=""                                ;ins_as=""                                 ;;
				'ops____________4') ins___=""                                ; ins__s=""                                ; ins_a_=""                                ;ins_as=""                                 ;;
				'ops____________5') ins___=""                                ; ins__s=""                                ; ins_a_=""                                ;ins_as=""                                 ;;
				'ops____________6') ins___=""                                ; ins__s=""                                ; ins_a_=""                                ;ins_as=""                                 ;;
				'ops____________7') ins___=""                                ; ins__s=""                                ; ins_a_=""                                ;ins_as=""                                 ;;
				'ops____________8') ins___=""                                ; ins__s=""                                ; ins_a_=""                                ;ins_as=""                                 ;;
				'ops____________9') ins___=""                                ; ins__s=""                                ; ins_a_=""                                ;ins_as=""                                 ;;
				'cua___________f1') ins___=""                                ; ins__s=""                                ; ins_a_=""                                ;ins_as=""                                 ;;
				'cua___________f2') ins___=""                                ; ins__s=""                                ; ins_a_=""                                ;ins_as=""                                 ;;
				'cua___________f3') ins___=""                                ; ins__s=""                                ; ins_a_=""                                ;ins_as=""                                 ;;
				'cua___________f4') ins___=""                                ; ins__s=""                                ; ins_a_=""                                ;ins_as=""                                 ;;
				'cua___________f5') ins___=""                                ; ins__s=""                                ; ins_a_=""                                ;ins_as=""                                 ;;
				'cua___________f6') ins___=""                                ; ins__s=""                                ; ins_a_=""                                ;ins_as=""                                 ;;
				'cua___________f7') ins___=""                                ; ins__s=""                                ; ins_a_=""                                ;ins_as=""                                 ;;
				'cua___________f8') ins___=""                                ; ins__s=""                                ; ins_a_=""                                ;ins_as=""                                 ;;
				'cua___________f9') ins___=""                                ; ins__s=""                                ; ins_a_=""                                ;ins_as=""                                 ;;
				'cua__________f10') ins___=""                                ; ins__s=""                                ; ins_a_=""                                ;ins_as=""                                 ;;
				'cua__________f11') ins___=""                                ; ins__s=""                                ; ins_a_=""                                ;ins_as=""                                 ;;
				'cua__________f12') ins___=""                                ; ins__s=""                                ; ins_a_=""                                ;ins_as=""                                 ;;
				'cua_________left') ins___="<left>"                          ; nor__s="<a-;><H>"                        ; ins_a_="<a-;><lt>"                       ;nor_as="<a-;><a-lt>"                      ;;
				'cua________right') ins___="<right>"                         ; nor__s="<a-;><L>"                        ; ins_a_="<a-;><gt>"                       ;nor_as="<a-;><a-gt>"                      ;;
				'cua___________up') ins___="<up>"                            ; ins__s="<a-;><K>"                        ; ins_a_=""                                ;ins_as=""                                 ;;
				'cua_________down') ins___="<down>"                          ; ins__s="<a-;><J>"                        ; ins_a_=""                                ;ins_as=""                                 ;;
				'cua_______pageup') ins___="<a-;><c-b>"                      ; nor__s="<a-;><c-b>"                      ; ins_a_=""                                ;ins_as=""                                 ;;
				'cua_____pagedown') ins___="<a-;><c-f>"                      ; nor__s="<a-;><c-f>"                      ; ins_a_=""                                ;ins_as=""                                 ;;
				'cua_________home') ins___="<a-;><a-h>"                      ; nor__s="<a-;><a-H>"                      ; ins_a_=""                                ;ins_as=""                                 ;;
				'cua__________end') ins___="<a-;><a-l>"                      ; nor__s="<a-;><a-L>"                      ; ins_a_=""                                ;ins_as=""                                 ;;
				'cua________cycle') ins___=""                                ; ins__s=""                                ; ins_a_=""                                ;ins_as=""                                 ;;
				'cua____backspace') ins___=""                                ; ins__s=""                                ; ins_a_="<backspace>"                     ;ins_as=""                                 ;;
				'cua_______delete') ins___=""                                ; ins__s=""                                ; ins_a_="<del>"                           ;ins_as=""                                 ;;
				'cua______advance') ins___=""                                ; ins__s=""                                ; ins_a_=""                                ;ins_as=""                                 ;;
				'cua_________exit') ins___="<esc>"                           ; ins__s=""                                ; ins_a_="<esc>"                           ;ins_as=""                                 ;;
				'cua________enter') ins___=""                                ; ins__s=""                                ; ins_a_="<ret>"                           ;ins_as=""                                 ;;
				'nav_________left') ins___=""                                ; ins__s=""                                ; ins_a_="<left>"                          ;ins_as="<home>"                           ;;
				'nav________right') ins___=""                                ; ins__s=""                                ; ins_a_="<right>"                         ;ins_as="<end>"                            ;;
				'nav___________up') ins___=""                                ; ins__s=""                                ; ins_a_="<up>"                            ;ins_as=""                                 ;;
				'nav_________down') ins___=""                                ; ins__s=""                                ; ins_a_="<down>"                          ;ins_as=""                                 ;;
				'nav_____backward') ins___=""                                ; ins__s=""                                ; ins_a_=""                                ;ins_as=""                                 ;;
				'nav______forward') ins___=""                                ; ins__s=""                                ; ins_a_=""                                ;ins_as=""                                 ;;
				'nav________taget') ins___=""                                ; ins__s=""                                ; ins_a_=""                                ;ins_as=""                                 ;;
				'nav________cycle') ins___=""                                ; ins__s=""                                ; ins_a_=""                                ;ins_as=""                                 ;;
				'nav________local') ins___=""                                ; ins__s=""                                ; ins_a_=""                                ;ins_as=""                                 ;;
				'nav________quick') ins___=""                                ; ins__s=""                                ; ins_a_=""                                ;ins_as=""                                 ;;
				'nav_________load') ins___=""                                ; ins__s=""                                ; ins_a_=""                                ;ins_as=""                                 ;;
				'nav_________item') ins___=""                                ; ins__s=""                                ; ins_a_=""                                ;ins_as=""                                 ;;
				'nav________focus') ins___=""                                ; ins__s=""                                ; ins_a_="<a-;>"                           ;ins_as="<esc>"                            ;;
				'nav_______select') ins___=""                                ; ins__s=""                                ; ins_a_=""                                ;ins_as=""                                 ;;
				'nav_________next') ins___=""                                ; ins__s=""                                ; ins_a_=""                                ;ins_as=""                                 ;;
				'nav_________prev') ins___=""                                ; ins__s=""                                ; ins_a_=""                                ;ins_as=""                                 ;;
				'act______primary') ins___=""                                ; ins__s=""                                ; ins_a_="<c-v>"                           ;ins_as="<c-u>"                            ;;
				'act____secondary') ins___=""                                ; ins__s=""                                ; ins_a_=""                                ;ins_as=""                                 ;;
				'act__alternative') ins___=""                                ; ins__s=""                                ; ins_a_="<c-r>"                           ;ins_as=""                                 ;;
				'act__________cut') ins___=""                                ; ins__s=""                                ; ins_a_=""                                ;ins_as=""                                 ;;
				'act___________in') ins___=""                                ; ins__s=""                                ; ins_a_=""                                ;ins_as=""                                 ;;
				'act__________out') ins___=""                                ; ins__s=""                                ; ins_a_=""                                ;ins_as=""                                 ;;
				'env_________edit') ins___=""                                ; ins__s=""                                ; ins_a_=""                                ;ins_as=""                                 ;;
				'env__________new') ins___=""                                ; ins__s=""                                ; ins_a_=""                                ;ins_as=""                                 ;;
				'env________group') ins___=""                                ; ins__s=""                                ; ins_a_=""                                ;ins_as=""                                 ;;
				'env______command') ins___=""                                ; ins__s=""                                ; ins_a_=""                                ;ins_as=""                                 ;;
				'env_____terminal') ins___=""                                ; ins__s=""                                ; ins_a_=""                                ;ins_as=""                                 ;;
				'env______history') ins___=""                                ; ins__s=""                                ; ins_a_=""                                ;ins_as=""                                 ;;
				'env___________re') ins___=""                                ; ins__s=""                                ; ins_a_=""                                ;ins_as=""                                 ;;
				'env_______record') ins___=""                                ; ins__s=""                                ; ins_a_=""                                ;ins_as=""                                 ;;
				'env_________done') ins___=""                                ; ins__s=""                                ; ins_a_=""                                ;ins_as=""                                 ;;
				'env_________code') ins___=""                                ; ins__s=""                                ; ins_a_="<c-o>"                           ;ins_as="<c-x>"                            ;;
				'env_______person') ins___=""                                ; ins__s=""                                ; ins_a_=""                                ;ins_as=""                                 ;;
				'vie_________view') ins___=""                                ; ins__s=""                                ; ins_a_=""                                ;ins_as=""                                 ;;
				'vie________minus') ins___=""                                ; ins__s=""                                ; ins_a_=""                                ;ins_as=""                                 ;;
				'vie_________plus') ins___=""                                ; ins__s=""                                ; ins_a_=""                                ;ins_as=""                                 ;;
				'vie________equal') ins___=""                                ; ins__s=""                                ; ins_a_=""                                ;ins_as=""                                 ;;
			esac

			case $key in
				'ops____________0') pro___=""                                ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'ops____________1') pro___=""                                ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'ops____________2') pro___=""                                ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'ops____________3') pro___=""                                ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'ops____________4') pro___=""                                ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'ops____________5') pro___=""                                ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'ops____________6') pro___=""                                ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'ops____________7') pro___=""                                ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'ops____________8') pro___=""                                ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'ops____________9') pro___=""                                ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'cua___________f1') pro___=""                                ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'cua___________f2') pro___=""                                ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'cua___________f3') pro___=""                                ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'cua___________f4') pro___=""                                ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'cua___________f5') pro___=""                                ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'cua___________f6') pro___=""                                ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'cua___________f7') pro___=""                                ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'cua___________f8') pro___=""                                ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'cua___________f9') pro___=""                                ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'cua__________f10') pro___=""                                ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'cua__________f11') pro___=""                                ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'cua__________f12') pro___=""                                ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'cua_________left') pro___="<left>"                          ; pro__s="<home>"                          ; pro_a_=""                                ; pro_as=""                                ;;
				'cua________right') pro___="<right>"                         ; pro__s="<end>"                           ; pro_a_=""                                ; pro_as=""                                ;;
				'cua___________up') pro___="<up>"                            ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'cua_________down') pro___="<down>"                          ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'cua_______pageup') pro___=""                                ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'cua_____pagedown') pro___=""                                ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'cua_________home') pro___=""                                ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'cua__________end') pro___=""                                ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'cua________cycle') pro___="<tab>"                           ; pro__s="<s-tab>"                         ; pro_a_=""                                ; pro_as=""                                ;;
				'cua____backspace') pro___="<backspace>"                     ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'cua_______delete') pro___="<del>"                           ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'cua______advance') pro___=""                                ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'cua_________exit') pro___="<esc>"                           ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'cua________enter') pro___="<ret>"                           ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'nav_________left') pro___=""                                ; pro__s=""                                ; pro_a_="<left>"                          ; pro_as="<home>"                          ;;
				'nav________right') pro___=""                                ; pro__s=""                                ; pro_a_="<right>"                         ; pro_as="<end>"                           ;;
				'nav___________up') pro___=""                                ; pro__s=""                                ; pro_a_="<up>"                            ; pro_as=""                                ;;
				'nav_________down') pro___=""                                ; pro__s=""                                ; pro_a_="<down>"                          ; pro_as=""                                ;;
				'nav_____backward') pro___=""                                ; pro__s=""                                ; pro_a_="<a-b>"                           ; pro_as="<a-B>"                           ;;
				'nav______forward') pro___=""                                ; pro__s=""                                ; pro_a_="<a-e><right>"                    ; pro_as="<a-E><right>"                    ;;
				'nav________taget') pro___=""                                ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'nav________cycle') pro___=""                                ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'nav________local') pro___=""                                ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'nav________quick') pro___=""                                ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'nav_________load') pro___=""                                ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'nav_________item') pro___=""                                ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'nav________focus') pro___=""                                ; pro__s=""                                ; pro_a_="<a-;>"                           ; pro_as="<esc>"                           ;;
				'nav_______select') pro___=""                                ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'nav_________next') pro___=""                                ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'nav_________prev') pro___=""                                ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'act______primary') pro___=""                                ; pro__s=""                                ; pro_a_="<c-v>"                           ; pro_as=""                                ;;
				'act____secondary') pro___=""                                ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'act__alternative') pro___=""                                ; pro__s=""                                ; pro_a_="<c-r>"                           ; pro_as="<c-y>"                           ;;
				'act__________cut') pro___=""                                ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'act___________in') pro___=""                                ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'act__________out') pro___=""                                ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'env_________edit') pro___=""                                ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'env__________new') pro___=""                                ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'env________group') pro___=""                                ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'env______command') pro___=""                                ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'env_____terminal') pro___=""                                ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'env______history') pro___=""                                ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'env___________re') pro___=""                                ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'env_______record') pro___=""                                ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'env_________done') pro___=""                                ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'env_________code') pro___=""                                ; pro__s=""                                ; pro_a_="<c-o>"                           ; pro_as="<a-!>"                           ;;
				'env_______person') pro___=""                                ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'vie_________view') pro___=""                                ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'vie________minus') pro___=""                                ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'vie_________plus') pro___=""                                ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
				'vie________equal') pro___=""                                ; pro__s=""                                ; pro_a_=""                                ; pro_as=""                                ;;
			esac

			case $key in
				'ops____________0') men___=""                                ; men__s=""                                ; men_a_=""                                ; men_as=""                                ;;
				'ops____________1') men___=""                                ; men__s=""                                ; men_a_=""                                ; men_as=""                                ;;
				'ops____________2') men___=""                                ; men__s=""                                ; men_a_=""                                ; men_as=""                                ;;
				'ops____________3') men___=""                                ; men__s=""                                ; men_a_=""                                ; men_as=""                                ;;
				'ops____________4') men___=""                                ; men__s=""                                ; men_a_=""                                ; men_as=""                                ;;
				'ops____________5') men___=""                                ; men__s=""                                ; men_a_=""                                ; men_as=""                                ;;
				'ops____________6') men___=""                                ; men__s=""                                ; men_a_=""                                ; men_as=""                                ;;
				'ops____________7') men___=""                                ; men__s=""                                ; men_a_=""                                ; men_as=""                                ;;
				'ops____________8') men___=""                                ; men__s=""                                ; men_a_=""                                ; men_as=""                                ;;
				'ops____________9') men___=""                                ; men__s=""                                ; men_a_=""                                ; men_as=""                                ;;
				'cua___________f1') men___=""                                ; men__s=""                                ; men_a_=""                                ; men_as=""                                ;;
				'cua___________f2') men___=""                                ; men__s=""                                ; men_a_=""                                ; men_as=""                                ;;
				'cua___________f3') men___=""                                ; men__s=""                                ; men_a_=""                                ; men_as=""                                ;;
				'cua___________f4') men___=""                                ; men__s=""                                ; men_a_=""                                ; men_as=""                                ;;
				'cua___________f5') men___=""                                ; men__s=""                                ; men_a_=""                                ; men_as=""                                ;;
				'cua___________f6') men___=""                                ; men__s=""                                ; men_a_=""                                ; men_as=""                                ;;
				'cua___________f7') men___=""                                ; men__s=""                                ; men_a_=""                                ; men_as=""                                ;;
				'cua___________f8') men___=""                                ; men__s=""                                ; men_a_=""                                ; men_as=""                                ;;
				'cua___________f9') men___=""                                ; men__s=""                                ; men_a_=""                                ; men_as=""                                ;;
				'cua__________f10') men___=""                                ; men__s=""                                ; men_a_=""                                ; men_as=""                                ;;
				'cua__________f11') men___=""                                ; men__s=""                                ; men_a_=""                                ; men_as=""                                ;;
				'cua__________f12') men___=""                                ; men__s=""                                ; men_a_=""                                ; men_as=""                                ;;
				'cua_________left') men___="<;><G><i>"                       ; men__s="<;><G><h>"                       ; men_a_="<G><i>"                          ; men_as="<G><h>"                          ;;
				'cua________right') men___="<;><G><l>"                       ; men__s="<;><G><j>"                       ; men_a_="<G><l>"                          ; men_as="<G><j>"                          ;;
				'cua___________up') men___="<;><G><g>"                       ; men__s="<;><G><t>"                       ; men_a_="<G><g>"                          ; men_as="<G><t>"                          ;;
				'cua_________down') men___="<;><G><e>"                       ; men__s="<;><G><b>"                       ; men_a_="<G><e>"                          ; men_as="<G><b>"                          ;;
				'cua_______pageup') men___=""                                ; men__s=""                                ; men_a_=""                                ; men_as=""                                ;;
				'cua_____pagedown') men___=""                                ; men__s=""                                ; men_a_=""                                ; men_as=""                                ;;
				'cua_________home') men___=""                                ; men__s=""                                ; men_a_=""                                ; men_as=""                                ;;
				'cua__________end') men___=""                                ; men__s=""                                ; men_a_=""                                ; men_as=""                                ;;
				'cua________cycle') men___=""                                ; men__s=""                                ; men_a_=""                                ; men_as=""                                ;;
				'cua____backspace') men___=""                                ; men__s=""                                ; men_a_=""                                ; men_as=""                                ;;
				'cua_______delete') men___=""                                ; men__s=""                                ; men_a_=""                                ; men_as=""                                ;;
				'cua______advance') men___=": bkey-line<ret>"                ; men__s=""                                ; men_a_=": bkey-line e<ret>"              ; men_as=""                                ;;
				'cua_________exit') men___=": bkey<ret>"                     ; men__s=""                                ; men_a_=""                                ; men_as=""                                ;;
				'cua________enter') men___="<g><f>"                          ; men__s=""                                ; men_a_=""                                ; men_as=""                                ;;
				'nav_________left') men___="<;><G><i>"                       ; men__s="<;><G><h>"                       ; men_a_="<G><i>"                          ; men_as="<G><h>"                          ;;
				'nav________right') men___="<;><G><l>"                       ; men__s="<;><G><l>"                       ; men_a_="<G><l>"                          ; men_as="<G><j>"                          ;;
				'nav___________up') men___="<;><G><g>"                       ; men__s="<;><G><t>"                       ; men_a_="<G><g>"                          ; men_as="<G><t>"                          ;;
				'nav_________down') men___="<;><G><e>"                       ; men__s="<;><G><b>"                       ; men_a_="<G><e>"                          ; men_as="<G><b>"                          ;;
				'nav_____backward') men___="<c-u>"                           ; men__s="<c-b>"                           ; men_a_=""                                ; men_as=""                                ;;
				'nav______forward') men___="<c-d>"                           ; men__s="<c-f>"                           ; men_a_=""                                ; men_as=""                                ;;
				'nav________taget') men___="<a-*>"                           ; men__s="<*>"                             ; men_a_="<a-*><%%%%><s><ret>"             ; men_as="<*><%%%%><s><ret>"               ;;
				'nav________cycle') men___=""                                ; men__s=""                                ; men_a_=""                                ; men_as=""                                ;;
				'nav________local') men___="<t>"                             ; men__s="<a-t>"                           ; men_a_="<T>"                             ; men_as="<a-T>"                           ;;
				'nav________quick') men___="<;><G><j>"                       ; men__s="<;><G><c>"                       ; men_a_="<G><j>"                          ; men_as="<G><c>"                          ;;
				'nav_________load') men___="<a-z>"                           ; men__s="<a-Z>"                           ; men_a_=""                                ; men_as=""                                ;;
				'nav_________item') men___=""                                ; men__s=""                                ; men_a_=""                                ; men_as=""                                ;;
				'nav________focus') men___="<a-s>"                           ; men__s="<a-S>"                           ; men_a_=""                                ; men_as=""                                ;;
				'nav_______select') men___=""                                ; men__s=""                                ; men_a_=""                                ; men_as=""                                ;;
				'nav_________next') men___=""                                ; men__s=""                                ; men_a_=""                                ; men_as=""                                ;;
				'nav_________prev') men___=""                                ; men__s=""                                ; men_a_=""                                ; men_as=""                                ;;
				'act______primary') men___="<s>"                             ; men__s="<S>"                             ; men_a_=""                                ; men_as=""                                ;;
				'act____secondary') men___=""                                ; men__s=""                                ; men_a_=""                                ; men_as=""                                ;;
				'act__alternative') men___="<@>"                             ; men__s="<a-@>"                           ; men_a_=""                                ; men_as=""                                ;;
				'act__________cut') men___=""                                ; men__s=""                                ; men_a_=""                                ; men_as=""                                ;;
				'act___________in') men___=""                                ; men__s=""                                ; men_a_=""                                ; men_as=""                                ;;
				'act__________out') men___=": bkey-ins pa<ret>"              ; men__s="<a-R>"                           ; men_a_=": bkey-ins pea<ret>"             ; men_as=""                                ;;
				'env_________edit') men___="<a-k>"                           ; men__s="<a-K>"                           ; men_a_=""                                ; men_as=""                                ;;
				'env__________new') men___="<o>"                             ; men__s="<O>"                             ; men_a_=""                                ; men_as=""                                ;;
				'env________group') men___=""                                ; men__s=""                                ; men_a_=""                                ; men_as=""                                ;;
				'env______command') men___=""                                ; men__s=""                                ; men_a_=""                                ; men_as=""                                ;;
				'env_____terminal') men___="<$>"                             ; men__s=""                                ; men_a_=""                                ; men_as=""                                ;;
				'env______history') men___="<;><G><.>"                       ; men__s="<;><G><a>"                       ; men_a_="<G><.>"                          ; men_as="<G><a>"                          ;;
				'env___________re') men___=""                                ; men__s=""                                ; men_a_=""                                ; men_as=""                                ;;
				'env_______record') men___=""                                ; men__s=""                                ; men_a_=""                                ; men_as=""                                ;;
				'env_________done') men___=""                                ; men__s=""                                ; men_a_=""                                ; men_as=""                                ;;
				'env_________code') men___=""                                ; men__s=""                                ; men_a_=""                                ; men_as=""                                ;;
				'env_______person') men___=""                                ; men__s=""                                ; men_a_=""                                ; men_as=""                                ;;
				'vie_________view') men___=""                                ; men__s=""                                ; men_a_=""                                ; men_as=""                                ;;
				'vie________minus') men___=""                                ; men__s=""                                ; men_a_=""                                ; men_as=""                                ;;
				'vie_________plus') men___=""                                ; men__s=""                                ; men_a_=""                                ; men_as=""                                ;;
				'vie________equal') men___=""                                ; men__s=""                                ; men_a_=""                                ; men_as=""                                ;;
			esac

			case $key in
				'ops____________0') vie___="<0>"                             ; vie__s=""                                ;;
				'ops____________1') vie___="<1>"                             ; vie__s=""                                ;;
				'ops____________2') vie___="<2>"                             ; vie__s=""                                ;;
				'ops____________3') vie___="<3>"                             ; vie__s=""                                ;;
				'ops____________4') vie___="<4>"                             ; vie__s=""                                ;;
				'ops____________5') vie___="<5>"                             ; vie__s=""                                ;;
				'ops____________6') vie___="<6>"                             ; vie__s=""                                ;;
				'ops____________7') vie___="<7>"                             ; vie__s=""                                ;;
				'ops____________8') vie___="<8>"                             ; vie__s=""                                ;;
				'ops____________9') vie___="<9>"                             ; vie__s=""                                ;;
				'cua___________f1') vie___=""                                ; vie__s=""                                ;;
				'cua___________f2') vie___=""                                ; vie__s=""                                ;;
				'cua___________f3') vie___=""                                ; vie__s=""                                ;;
				'cua___________f4') vie___=""                                ; vie__s=""                                ;;
				'cua___________f5') vie___=""                                ; vie__s=""                                ;;
				'cua___________f6') vie___=""                                ; vie__s=""                                ;;
				'cua___________f7') vie___=""                                ; vie__s=""                                ;;
				'cua___________f8') vie___=""                                ; vie__s=""                                ;;
				'cua___________f9') vie___=""                                ; vie__s=""                                ;;
				'cua__________f10') vie___=""                                ; vie__s=""                                ;;
				'cua__________f11') vie___=""                                ; vie__s=""                                ;;
				'cua__________f12') vie___=""                                ; vie__s=""                                ;;
				'cua_________left') vie___="<v><h>"                          ; vie__s="%%val{window_width}<v><h>"       ;;
				'cua________right') vie___="<v><l>"                          ; vie__s="%%val{window_width}<v><l>"       ;;
				'cua___________up') vie___="<v><k>"                          ; vie__s="<v><b>"                          ;;
				'cua_________down') vie___="<v><j>"                          ; vie__s="<v><t>"                          ;;
				'cua_______pageup') vie___=""                                ; vie__s=""                                ;;
				'cua_____pagedown') vie___=""                                ; vie__s=""                                ;;
				'cua_________home') vie___=""                                ; vie__s=""                                ;;
				'cua__________end') vie___=""                                ; vie__s=""                                ;;
				'cua________cycle') nor___=": buffer-previous<ret>"          ; nor__s=": buffer-next<ret>"              ;;
				'cua____backspace') vie___=""                                ; vie__s=""                                ;;
				'cua_______delete') vie___=""                                ; vie__s=""                                ;;
				'cua______advance') vie___="<V><c><m><esc>"                  ; vie__s=""                                ;;
				'cua_________exit') vie___=": bkey<ret>"                     ; vie__s=""                                ;;
				'cua________enter') vie___=""                                ; vie__s=""                                ;;
				'nav_________left') vie___="<v><h>"                          ; vie__s="%%val{window_width}<v><h>"       ;;
				'nav________right') vie___="<v><l>"                          ; vie__s="%%val{window_width}<v><l>"       ;;
				'nav___________up') vie___="<v><k>"                          ; vie__s="<v><b>"                          ;;
				'nav_________down') vie___="<v><j>"                          ; vie__s="<v><t>"                          ;;
				'nav_____backward') vie___="<c-u>"                           ; vie__s="<c-b>"                           ;;
				'nav______forward') vie___="<c-d>"                           ; vie__s="<c-f>"                           ;;
				'nav________taget') vie___=""                                ; vie__s=""                                ;;
				'nav________cycle') vie___=""                                ; vie__s=""                                ;;
				'nav________local') vie___=""                                ; vie__s=""                                ;;
				'nav________quick') vie___="<v><m>"                          ; vie__s="<v><c>"                          ;;
				'nav_________load') vie___=""                                ; vie__s=""                                ;;
				'nav_________item') vie___="<)>"                             ; vie__s="<(>"                             ;;
				'nav________focus') vie___=""                                ; vie__s=""                                ;;
				'nav_______select') vie___=""                                ; vie__s=""                                ;;
				'nav_________next') vie___=""                                ; vie__s=""                                ;;
				'nav_________prev') vie___=""                                ; vie__s=""                                ;;
				'act______primary') vie___=""                                ; vie__s=""                                ;;
				'act____secondary') vie___=""                                ; vie__s=""                                ;;
				'act__alternative') vie___=""                                ; vie__s=""                                ;;
				'act__________cut') vie___=""                                ; vie__s=""                                ;;
				'act___________in') vie___=""                                ; vie__s=""                                ;;
				'act__________out') vie___=""                                ; vie__s=""                                ;;
				'env_________edit') vie___=""                                ; vie__s=""                                ;;
				'env__________new') vie___=""                                ; vie__s=""                                ;;
				'env________group') vie___=""                                ; vie__s=""                                ;;
				'env______command') vie___=""                                ; vie__s=""                                ;;
				'env_____terminal') vie___=""                                ; vie__s=""                                ;;
				'env______history') vie___=""                                ; vie__s=""                                ;;
				'env___________re') vie___=""                                ; vie__s=""                                ;;
				'env_______record') vie___=""                                ; vie__s=""                                ;;
				'env_________done') vie___=""                                ; vie__s=""                                ;;
				'env_________code') vie___=""                                ; vie__s=""                                ;;
				'env_______person') vie___=""                                ; vie__s=""                                ;;
				'vie_________view') vie___="<V><c><m><esc>: bkey<ret>"       ; vie__s=""                                ;;
				'vie________minus') vie___=""                                ; vie__s=""                                ;;
				'vie_________plus') vie___=""                                ; vie__s=""                                ;;
				'vie________equal') vie___=""                                ; vie__s=""                                ;;
			esac


			case $key in
				'normal')
					[ -n "$key___" ]                     && maps="$maps map   global normal \"$key___\"      \"$nor___\";"
					[ -n "$key__s" ]                     && maps="$maps map   global normal \"$key__s\"      \"$nor__s\";"
					[ -n "$key_a_" ]                     && maps="$maps map   global normal \"$key_a_\"      \"$nor_a_\";"
					[ -n "$key_as" ]                     && maps="$maps map   global normal \"$key_as\"      \"$nor_as\";"
					[ -n "$key_c_" ]                     && maps="$maps map   global normal \"$key_c_\"      \"$nor_c_\";"
					[ -n "$key_cs" ]                     && maps="$maps map   global normal \"$key_cs\"      \"$nor_cs\";"

					[ -n "$key___" ] && [ -n "$ins___" ] && maps="$maps map   global insert \"$key___\"      \"$ins___\";"
					[ -n "$key__s" ] && [ -n "$ins__s" ] && maps="$maps map   global insert \"$key__s\"      \"$ins__s\";"
					[ -n "$key_a_" ] && [ -n "$ins_a_" ] && maps="$maps map   global insert \"$key_a_\"      \"$ins_a_\";"
					[ -n "$key_as" ] && [ -n "$ins_as" ] && maps="$maps map   global insert \"$key_as\"      \"$ins_as\";"
					[ -n "$key_a_" ] && [ -z "$ins_a_" ] && maps="$maps map   global insert \"$key_a_\" \"<a-;>$nor___\";"
					[ -n "$key_as" ] && [ -z "$ins_as" ] && maps="$maps map   global insert \"$key_as\" \"<a-;>$nor__s\";"
					[ -n "$key_c_" ]                     && maps="$maps map   global insert \"$key_c_\" \"<a-;>$nor_c_\";"
					[ -n "$key_cs" ]                     && maps="$maps map   global insert \"$key_cs\" \"<a-;>$nor_cs\";"

					[ -n "$key___" ] && [ -n "$pro___" ] && maps="$maps map   global prompt \"$key___\"      \"$pro___\";"
					[ -n "$key__s" ] && [ -n "$pro__s" ] && maps="$maps map   global prompt \"$key__s\"      \"$pro__s\";"
					[ -n "$key_a_" ]                     && maps="$maps map   global prompt \"$key_a_\"      \"$pro_a_\";"
					[ -n "$key_as" ]                     && maps="$maps map   global prompt \"$key_as\"      \"$pro_as\";"
					[ -n "$key_c_" ]                     && maps="$maps map   global prompt \"$key_c_\"      \"$pro_c_\";"
					[ -n "$key_cs" ]                     && maps="$maps map   global prompt \"$key_cs\"      \"$pro_cs\";"

					[ "$key" = 'cua________cycle' ] && maps="
						hook global InsertCompletionShow .* %%{
							map   global insert \"$key___\" \"<c-n>\";
							map   global insert \"$key__s\" \"<c-p>\"
						};
						hook global InsertCompletionHide .* %%{
							unmap global insert \"$key___\" \"<c-n>\";
							unmap global insert \"$key__s\" \"<c-p>\"
						};
					"
				;;
				'menu')
					[ -n "$key___" ] && [ -n "$men___" ] && maps="$maps map   window normal \"$key___\" \"$flag$men___\";"
					[ -n "$key__s" ] && [ -n "$men__s" ] && maps="$maps map   window normal \"$key__s\" \"$flag$men__s\";"
					[ -n "$key_a_" ] && [ -n "$men_a_" ] && maps="$maps map   window normal \"$key_a_\" \"$flag$men_a_\";"
					[ -n "$key_as" ] && [ -n "$men_as" ] && maps="$maps map   window normal \"$key_as\" \"$flag$men_as\";"
					[ -n "$key___" ] && [ -z "$men___" ] && maps="$maps map   window normal \"$key___\"             \"\";"
					[ -n "$key__s" ] && [ -z "$men__s" ] && maps="$maps map   window normal \"$key__s\"             \"\";"
					[ -n "$key_a_" ] && [ -z "$men_a_" ] && maps="$maps map   window normal \"$key_a_\"             \"\";"
					[ -n "$key_as" ] && [ -z "$men_as" ] && maps="$maps map   window normal \"$key_as\"             \"\";"
					[ -n "$key_c_" ]                     && maps="$maps map   window normal \"$key_c_\"             \"\";"
					[ -n "$key_cs" ]                     && maps="$maps map   window normal \"$key_cs\"             \"\";"
				;;
				'view')
					[ -n "$key___" ]                     && maps="$maps map   global normal \"$key___\"      \"$vie___\";"
					[ -n "$key__s" ]                     && maps="$maps map   global normal \"$key__s\"      \"$vie__s\";"
					[ -n "$key_a_" ]                     && maps="$maps map   global normal \"$key_a_\"      \"$vie_a_\";"
					[ -n "$key_as" ]                     && maps="$maps map   global normal \"$key_as\"      \"$vie_as\";"
					[ -n "$key_c_" ]                     && maps="$maps map   global normal \"$key_c_\"      \"$vie_c_\";"
					[ -n "$key_cs" ]                     && maps="$maps map   global normal \"$key_cs\"      \"$vie_cs\";"
				;;
				'off')
					[ -n "$key___" ]                     && null="$null unmap global normal \"$key___\"                 ;"
					[ -n "$key__s" ]                     && null="$null unmap global normal \"$key__s\"                 ;"
					[ -n "$key_a_" ]                     && null="$null unmap global normal \"$key_a_\"                 ;"
					[ -n "$key_as" ]                     && null="$null unmap global normal \"$key_as\"                 ;"
					[ -n "$key_c_" ]                     && null="$null unmap global normal \"$key_c_\"                 ;"
					[ -n "$key_cs" ]                     && null="$null unmap global normal \"$key_cs\"                 ;"
				;;
			esac
		done


		# Start
		printf "$maps"
	}
}

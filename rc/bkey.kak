# Setup
declare-user-mode Goto
declare-user-mode Exto
declare-user-mode View
declare-user-mode VIEW
declare-user-mode Combine
declare-user-mode Combire
declare-user-mode Replace

define-command view 'enter-user-mode VIEW'
define-command default-goto 'execute-keys <g>'
define-command default-goto-ex 'execute-keys <s-g>'
define-command default-view 'execute-keys <v>'
define-command default-view-lock 'execute-keys <s-v>'
define-command default-combine 'execute-keys <a-z>'
define-command default-combine-re 'execute-keys <a-s-z>'

define-command smart-bol %{
	evaluate-commands %sh{
		if [[ "$kak_cursor_column" = '1' ]]; then
			echo "execute-keys <a-h>"
		else
			echo "execute-keys <g><i> ; \
				map global normal <s-j> '<a-h>' ; \
				hook -once global NormalKey . \"map global normal <s-j> ': smart-bol<ret>'\""
		fi
	}
}

define-command smart-ex-bol %{
	evaluate-commands %sh{
		if [[ "$kak_cursor_column" = '1' ]]; then
			echo "execute-keys <a-s-h>"
		else
			echo "execute-keys <s-g><i> ; \
				map global normal <a-s-j> '<a-s-h>' ; \
				hook -once global NormalKey . \"map global normal <a-s-j> ': smart-ex-bol<ret>'\""
		fi
	}
}

# Remap
	# Normal
		# Operations
			# Number
			map global normal  <0>                 '<0>'                                   -docstring ''
			map global normal  <1>                 '<1>'                                   -docstring ''
			map global normal  <2>                 '<2>'                                   -docstring ''
			map global normal  <3>                 '<3>'                                   -docstring ''
			map global normal  <4>                 '<4>'                                   -docstring ''
			map global normal  <5>                 '<5>'                                   -docstring ''
			map global normal  <6>                 '<6>'                                   -docstring ''
			map global normal  <7>                 '<7>'                                   -docstring ''
			map global normal  <8>                 '<8>'                                   -docstring ''
			map global normal  <9>                 '<9>'                                   -docstring ''
			map global normal  <)>                 ''                                      -docstring ''
			map global normal  <!>                 ''                                      -docstring ''
			map global normal  <@>                 ''                                      -docstring ''
			map global normal  <#>                 ''                                      -docstring ''
			map global normal  <$>                 ''                                      -docstring ''
			map global normal  <%>                 ''                                      -docstring ''
			map global normal  <^>                 ''                                      -docstring ''
			map global normal  <&>                 ''                                      -docstring ''
			map global normal  <*>                 ''                                      -docstring ''
			map global normal  <(>                 ''                                      -docstring ''
			map global normal  <a-0>               ''                                      -docstring ''
			map global normal  <a-1>               ''                                      -docstring ''
			map global normal  <a-2>               ''                                      -docstring ''
			map global normal  <a-3>               ''                                      -docstring ''
			map global normal  <a-4>               ''                                      -docstring ''
			map global normal  <a-5>               ''                                      -docstring ''
			map global normal  <a-6>               ''                                      -docstring ''
			map global normal  <a-7>               ''                                      -docstring ''
			map global normal  <a-8>               ''                                      -docstring ''
			map global normal  <a-9>               ''                                      -docstring ''
			map global normal  <a-)>               ''                                      -docstring ''
			map global normal  <a-!>               ''                                      -docstring ''
			map global normal  <a-@>               ''                                      -docstring ''
			map global normal  <a-#>               ''                                      -docstring ''
			map global normal  <a-$>               ''                                      -docstring ''
			map global normal  <a-%>               ''                                      -docstring ''
			map global normal  <a-^>               ''                                      -docstring ''
			map global normal  <a-&>               ''                                      -docstring ''
			map global normal  <a-*>               ''                                      -docstring ''
			map global normal  <a-(>               ''                                      -docstring ''

			# Menu
			map global normal  <t>                 '<,>'                                   -docstring ''
			map global normal  <s-t>               ''                                      -docstring ''
			map global normal  <a-t>               ''                                      -docstring ''
			map global normal  <a-s-t>             ''                                      -docstring ''

		# Modes
			# Insert
			map global normal  <d>                 '<i>'                                   -docstring ''
			map global normal  <s-d>               '<s-i>'                                 -docstring ''
			map global normal  <a-d>               '<s>'                                   -docstring ''
			map global normal  <a-s-d>             '<s-s>'                                 -docstring ''

			map global normal  <f>                 '<a>'                                   -docstring ''
			map global normal  <s-f>               '<s-a>'                                 -docstring ''
			map global normal  <a-f>               '<a-k>'                                 -docstring ''
			map global normal  <a-s-f>             '<a-s-k>'                               -docstring ''

			map global normal  <e>                 '<a-c>'                                 -docstring ''
			map global normal  <s-e>               '<a-l><a-c>'                            -docstring ''
			map global normal  <a-e>               '<r>'                                   -docstring ''
			map global normal  <a-s-e>             ': enter-user-mode Replace<ret>'        -docstring ''

			# Command prompt & terminal
			map global normal  <semicolon>         '<:>'                                   -docstring ''
			map global normal  <:>                 '<!>'                                   -docstring ''
			map global normal  <a-semicolon>       '<$>'                                   -docstring ''
			map global normal  <a-:>               '<a-!>'                                 -docstring ''

			map global normal  <`>                 ':terminal '                            -docstring ''
			map global normal  <~>                 ': terminal %val{client_env_SHELL}<ret>'    -docstring ''
			map global normal  <a-`>               '<a-|>'                                 -docstring ''
			map global normal  <a-~>               '<|>'                                   -docstring ''

		# Movements
			# Fuction keys
			map global normal  <left>              '<h>'                                   -docstring ''
			map global normal  <right>             '<l>'                                   -docstring ''
			map global normal  <up>                '<k>'                                   -docstring ''
			map global normal  <down>              '<j>'                                   -docstring ''
			map global normal  <pageup>            '<c-b>'                                 -docstring ''
			map global normal  <pagedown>          '<c-f>'                                 -docstring ''
			map global normal  <home>              '<a-h>'                                 -docstring ''
			map global normal  <end>               '<a-l>'                                 -docstring ''
			map global normal  <c-left>            '<b>'                                   -docstring ''
			map global normal  <c-right>           '<e>'                                   -docstring ''
			map global normal  <c-up>              '<k>'                                   -docstring ''
			map global normal  <c-down>            '<j>'                                   -docstring ''
			map global normal  <c-pageup>          '<c-u>'                                 -docstring ''
			map global normal  <c-pagedown>        '<c-d>'                                 -docstring ''
			map global normal  <c-home>            '<g><g>'                                -docstring ''
			map global normal  <c-end>             '<g><e>'                                -docstring ''
			map global normal  <s-left>            '<s-h>'                                 -docstring ''
			map global normal  <s-right>           '<s-l>'                                 -docstring ''
			map global normal  <s-up>              '<s-k>'                                 -docstring ''
			map global normal  <s-down>            '<s-j>'                                 -docstring ''
			map global normal  <s-pageup>          '<s-c-b>'                               -docstring ''
			map global normal  <s-pagedown>        '<s-c-f>'                               -docstring ''
			map global normal  <s-home>            '<a-s-h>'                               -docstring ''
			map global normal  <s-end>             '<a-s-l>'                               -docstring ''
			map global normal  <s-c-left>          '<s-b>'                                 -docstring ''
			map global normal  <s-c-right>         '<s-e>'                                 -docstring ''
			map global normal  <s-c-up>            '<s-k>'                                 -docstring ''
			map global normal  <s-c-down>          '<s-j>'                                 -docstring ''
			map global normal  <s-c-pageup>        '<s-c-u>'                               -docstring ''
			map global normal  <s-c-pagedown>      '<s-c-d>'                               -docstring ''
			map global normal  <s-c-home>          '<G><g>'                                -docstring ''
			map global normal  <s-c-end>           '<G><e>'                                -docstring ''
			map global normal  <a-left>            '<lt>'                                  -docstring ''
			map global normal  <a-right>           '<gt>'                                  -docstring ''
			map global normal  <a-up>              ''                                      -docstring ''
			map global normal  <a-down>            ''                                      -docstring ''
			map global normal  <a-s-left>          '<a-:><a-;><&>'                         -docstring ''
			map global normal  <a-s-right>         '<a-:><&>'                              -docstring ''
			map global normal  <a-s-up>            '<~>'                                   -docstring ''
			map global normal  <a-s-down>          '<`>'                                   -docstring ''

			map global normal  <tab>               ': buffer-next<ret>'                    -docstring ''
			map global normal  <s-tab>             ': buffer-previous<ret>'                -docstring ''

			# Simple
			map global normal  <j>                 '<h>'                                   -docstring ''
			map global normal  <l>                 '<l>'                                   -docstring ''
			map global normal  <i>                 '<k>'                                   -docstring ''
			map global normal  <k>                 '<j>'                                   -docstring ''
			map global normal  <s-j>               ': smart-bol<ret>'                      -docstring ''
			map global normal  <s-l>               '<a-l>'                                 -docstring ''
			map global normal  <s-i>               '<[>p'                                  -docstring ''
			map global normal  <s-k>               '<]>p'                                  -docstring ''
			map global normal  <a-j>               '<s-h>'                                 -docstring ''
			map global normal  <a-l>               '<s-l>'                                 -docstring ''
			map global normal  <a-i>               '<s-k>'                                 -docstring ''
			map global normal  <a-k>               '<s-j>'                                 -docstring ''
			map global normal  <a-s-j>             ': smart-ex-bol<ret>'                   -docstring ''
			map global normal  <a-s-l>             '<a-s-l>'                               -docstring ''
			map global normal  <a-s-i>             '<{>p'                                  -docstring ''
			map global normal  <a-s-k>             '<}>p'                                  -docstring ''

			map global normal  <u>                 '<b>'                                   -docstring ''
			map global normal  <o>                 '<e>'                                   -docstring ''
			map global normal  <s-u>               '<a-b>'                                 -docstring ''
			map global normal  <s-o>               '<a-e>'                                 -docstring ''
			map global normal  <a-u>               '<s-b>'                                 -docstring ''
			map global normal  <a-o>               '<s-e>'                                 -docstring ''
			map global normal  <a-s-u>             '<a-s-b>'                               -docstring ''
			map global normal  <a-s-o>             '<a-s-e>'                               -docstring ''

			# Search
			map global normal  <h>                 '</>'                                   -docstring ''
			map global normal  <s-h>               '<a-/>'                                 -docstring ''
			map global normal  <a-h>               '<?>'                                   -docstring ''
			map global normal  <a-s-h>             '<a-?>'                                 -docstring ''

			map global normal  <n>                 '<n>'                                   -docstring ''
			map global normal  <s-n>               '<a-n>'                                 -docstring ''
			map global normal  <a-n>               '<s-n>'                                 -docstring ''
			map global normal  <a-s-n>             '<a-s-n>'                               -docstring ''

			map global normal  <m>                 '<f>'                                   -docstring ''
			map global normal  <s-m>               '<a-f>'                                 -docstring ''
			map global normal  <a-m>               '<s-f>'                                 -docstring ''
			map global normal  <a-s-m>             '<a-s-f>'                               -docstring ''

			# Goto & Marks
			map global normal  <g>                 ': enter-user-mode Goto<ret>'           -docstring ''
			map global normal  <s-g>               '<m>'                                   -docstring ''
			map global normal  <a-g>               ': enter-user-mode Exto<ret>'           -docstring ''
			map global normal  <a-s-g>             '<M>'                                   -docstring ''

			map global normal  <,>                 '<z>'                                   -docstring ''
			map global normal  <lt>                '<s-z>'                                 -docstring ''
			map global normal  <a-,>               ': enter-user-mode Combine<ret>'        -docstring ''
			map global normal  <a-lt>              ': enter-user-mode Combire<ret>'        -docstring ''

			# Advance
			map global normal  <esc>               '<semicolon>'                           -docstring ''
			map global normal  <s-esc>             '<space>'                               -docstring ''
			map global normal  <a-esc>             '<space><semicolon>'                    -docstring ''
			map global normal  <a-s-esc>           '<esc>'                                 -docstring ''

			map global normal  <s>                 '<x>'                                   -docstring ''
			map global normal  <s-s>               '<s-x>'                                 -docstring ''
			map global normal  <a-s>               '<a-s-x>'                               -docstring ''
			map global normal  <a-s-s>             '<a-x>'                                 -docstring ''

			map global normal  <w>                 '<space>'                               -docstring ''
			map global normal  <s-w>               '<a-space>'                             -docstring ''
			map global normal  <a-w>               '<a-s>'                                 -docstring ''
			map global normal  <a-s-w>             '<_>'                                   -docstring ''

			map global normal  <q>                 '<)>'                                   -docstring ''
			map global normal  <s-q>               '<(>'                                   -docstring ''
			map global normal  <a-q>               '<a-)>'                                 -docstring ''
			map global normal  <a-s-q>             '<a-(>'                                 -docstring ''

			map global normal  <a>                 '<a-i>'                                 -docstring ''
			map global normal  <s-a>               '<a-a>'                                 -docstring ''
			map global normal  <a-a>               '<a-semicolon>'                         -docstring ''
			map global normal  <a-s-a>             '<a-s-s>'                               -docstring ''

			map global normal  <[>                 '<a-[>'                                 -docstring ''
			map global normal  <]>                 '<a-]>'                                 -docstring ''
			map global normal  <{>                 '<[>'                                   -docstring ''
			map global normal  <}>                 '<]>'                                   -docstring ''
			map global normal  <a-[>               '<a-{>'                                 -docstring ''
			map global normal  <a-]>               '<a-}>'                                 -docstring ''
			map global normal  <a-{>               '<{>'                                   -docstring ''
			map global normal  <a-}>               '<}>'                                   -docstring ''

		# Actions
			# Clipboard
			map global normal  <backspace>         '<;><h><a-d>'                           -docstring ''
			map global normal  <del>               '<;><a-d>'                              -docstring ''

			map global normal  <x>                 '<d>'                                   -docstring ''
			map global normal  <s-x>               '<a-l><d>'                              -docstring ''
			map global normal  <a-x>               '<a-d>'                                 -docstring ''
			map global normal  <a-s-x>             '<a-l><a-d>'                            -docstring ''

			map global normal  <c>                 '<y>'                                   -docstring ''
			map global normal  <s-c>               '<a-l><y>'                              -docstring ''
			map global normal  <a-c>               '<C>'                                   -docstring ''
			map global normal  <a-s-c>             '<a-C>'                                 -docstring ''

			map global normal  <v>                 '<s-p>'                                 -docstring ''
			map global normal  <s-v>               '<p>'                                   -docstring ''
			map global normal  <a-v>               '<a-s-p>'                               -docstring ''
			map global normal  <a-s-v>             '<a-p>'                                 -docstring ''

			# New lines
			map global normal  <p>                 '<a-o>'                                 -docstring ''
			map global normal  <s-p>               '<a-s-o>'                               -docstring ''
			map global normal  <a-p>               '<o>'                                   -docstring ''
			map global normal  <a-s-p>             '<s-o>'                                 -docstring ''

			# Group lines
			map global normal  <b>                 '<a-s-j>'                               -docstring ''
			map global normal  <s-b>               '<a-_>'                                 -docstring ''
			map global normal  <a-b>               '<a-j>'                                 -docstring ''
			map global normal  <a-s-b>             ''                                      -docstring ''

			# Comment line
			map global normal  </>                 ': comment-line<ret>'                   -docstring ''
			map global normal  <?>                 '<">'                                   -docstring ''
			map global normal  <a-/>               ': comment-block<ret>'                  -docstring ''
			map global normal  <a-?>               '<\>'                                   -docstring ''

			# Minus & Plus
			map global normal  <minus>             '<`>'                                   -docstring ''
			map global normal  <=>                 '<~>'                                   -docstring ''
			map global normal  <'>                 '<">'                                   -docstring ''
			map global normal  <_>                 '<`>'                                   -docstring ''
			map global normal  <plus>              '<~>'                                   -docstring ''
			map global normal  <">                 '<a-`>'                                 -docstring ''
			map global normal  <a-minus>           '<lt>'                                  -docstring ''
			map global normal  <a-=>               '<gt>'                                  -docstring ''
			map global normal  <a-'>               '<&>'                                   -docstring ''
			map global normal  <a-_>               '<a-lt>'                                -docstring ''
			map global normal  <a-plus>            '<a-gt>'                                -docstring ''
			map global normal  <a-">               '<a-&>'                                 -docstring ''

		# Views
		map global normal  <space>             ': enter-user-mode View<ret>'           -docstring ''
		map global normal  <a-space>           ': view<ret>'                           -docstring ''

		map global normal  <\>                 ''                                      -docstring ''
		map global normal  <|>                 ''                                      -docstring ''
		map global normal  <a-\>               ''                                      -docstring ''
		map global normal  <a-|>               ''                                      -docstring ''

		# Environments
		map global normal  <z>                 '<u>'                                   -docstring ''
		map global normal  <s-z>               '<s-u>'                                 -docstring ''
		map global normal  <a-z>               '<a-u>'                                 -docstring ''
		map global normal  <a-s-z>             '<a-s-u>'                               -docstring ''

		map global normal  <r>                 '<a-.>'                                 -docstring ''
		map global normal  <s-r>               '<.>'                                   -docstring ''
		map global normal  <a-r>               '<a-s-x>'                               -docstring ''
		map global normal  <a-s-r>             '<a-:>'                                 -docstring ''

		map global normal  <y>                 '<q>'                                   -docstring ''
		map global normal  <s-y>               '<Q>'                                   -docstring ''
		map global normal  <a-y>               ''                                      -docstring ''
		map global normal  <a-s-y>             ''                                      -docstring ''

		map global normal  <.>                 ': write<ret>'                          -docstring ''
		map global normal  <gt>                ': write-all<ret>'                      -docstring ''
		map global normal  <a-.>               ': write!<ret>'                         -docstring ''
		map global normal  <a-gt>              ': write-all!<ret>'                     -docstring ''

	# Insert
		# Unmap
		map global insert  <a-semicolon>       ''                                      -docstring 'unmap'

		# Modes
		map global insert  <esc>               '<esc>'                                 -docstring ''

		map global insert  <a-d>               '<c-r>'                                 -docstring ''
		map global insert  <a-s-d>             '<c-v>'                                 -docstring ''

		map global insert  <a-f>               '<a-semicolon>'                         -docstring ''
		map global insert  <a-s-f>             '<esc>'                                 -docstring ''

		map global insert  <a-s>               '<esc>'                                 -docstring ''

		# Movements
		map global insert  <left>              '<a-;><h>'                              -docstring ''
		map global insert  <right>             '<a-;><l>'                              -docstring ''
		map global insert  <up>                '<a-;><k>'                              -docstring ''
		map global insert  <down>              '<a-;><j>'                              -docstring ''
		map global insert  <pageup>            '<a-;><c-b>'                            -docstring ''
		map global insert  <pagedown>          '<a-;><c-f>'                            -docstring ''
		map global insert  <home>              '<a-;><a-h>'                            -docstring ''
		map global insert  <end>               '<a-;><a-l>'                            -docstring ''
		map global insert  <c-left>            '<a-;><b>'                              -docstring ''
		map global insert  <c-right>           '<a-;><e>'                              -docstring ''
		map global insert  <c-up>              '<a-;><k>'                              -docstring ''
		map global insert  <c-down>            '<a-;><j>'                              -docstring ''
		map global insert  <c-pageup>          '<a-;><c-u>'                            -docstring ''
		map global insert  <c-pagedown>        '<a-;><c-d>'                            -docstring ''
		map global insert  <c-home>            '<a-;><g><g>'                           -docstring ''
		map global insert  <c-end>             '<a-;><g><e>'                           -docstring ''
		map global insert  <s-left>            '<a-;><s-h>'                            -docstring ''
		map global insert  <s-right>           '<a-;><s-l>'                            -docstring ''
		map global insert  <s-up>              '<a-;><s-k>'                            -docstring ''
		map global insert  <s-down>            '<a-;><s-j>'                            -docstring ''
		map global insert  <s-pageup>          '<a-;><s-c-b>'                          -docstring ''
		map global insert  <s-pagedown>        '<a-;><s-c-f>'                          -docstring ''
		map global insert  <s-home>            '<a-;><a-s-h>'                          -docstring ''
		map global insert  <s-end>             '<a-;><a-s-l>'                          -docstring ''
		map global insert  <s-c-left>          '<a-;><s-b>'                            -docstring ''
		map global insert  <s-c-right>         '<a-;><s-e>'                            -docstring ''
		map global insert  <s-c-up>            '<a-;><s-k>'                            -docstring ''
		map global insert  <s-c-down>          '<a-;><s-j>'                            -docstring ''
		map global insert  <s-c-pageup>        '<a-;><s-c-u>'                          -docstring ''
		map global insert  <s-c-pagedown>      '<a-;><s-c-d>'                          -docstring ''
		map global insert  <s-c-home>          '<a-;><G><g>'                           -docstring ''
		map global insert  <s-c-end>           '<a-;><G><e>'                           -docstring ''
		map global insert  <a-left>            '<a-;><lt>'                             -docstring ''
		map global insert  <a-right>           '<a-;><gt>'                             -docstring ''
		map global insert  <a-up>              ''                                      -docstring ''
		map global insert  <a-down>            ''                                      -docstring ''
		map global insert  <a-s-left>          '<a-;><a-:><a-;><&>'                    -docstring ''
		map global insert  <a-s-right>         '<a-;><a-:><&>'                         -docstring ''
		map global insert  <a-s-up>            '<a-;><~>'                              -docstring ''
		map global insert  <a-s-down>          '<a-;><`>'                              -docstring ''

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

		map global insert  <a-j>               '<left>'                                -docstring ''
		map global insert  <a-l>               '<right>'                               -docstring ''
		map global insert  <a-i>               '<up>'                                  -docstring ''
		map global insert  <a-k>               '<down>'                                -docstring ''

		map global insert  <a-n>               '<c-n>'                                 -docstring ''
		map global insert  <a-s-n>             '<c-p>'                                 -docstring ''

		# Actions
		map global insert  <backspace>         '<backspace>'                           -docstring ''
		map global insert  <del>               '<del>'                                 -docstring ''

		# Environments
		map global insert  <a-a>               '<c-u>'                                 -docstring ''

		map global insert  <a-e>               '<c-o>'                                 -docstring ''
		map global insert  <a-s-e>             '<c-x>'                                 -docstring ''

	# Prompt
		# Unmap
		map global prompt  <a-f>               ''                                      -docstring 'unmap'
		map global prompt  <a-s-f>             ''                                      -docstring 'unmap'
		map global prompt  <a-b>               ''                                      -docstring 'unmap'
		map global prompt  <a-s-b>             ''                                      -docstring 'unmap'
		map global prompt  <a-e>               ''                                      -docstring 'unmap'
		map global prompt  <a-s-e>             ''                                      -docstring 'unmap'
		map global prompt  <a-d>               ''                                      -docstring 'unmap'
		map global prompt  <a-s-d>             ''                                      -docstring 'unmap'
		map global prompt  <a-semicolon>       ''                                      -docstring 'unmap'
		map global prompt  <a-!>               ''                                      -docstring 'unmap'

		# Modes
		map global prompt  <esc>               '<esc>'                                 -docstring ''
		map global prompt  <ret>               '<ret>'                                 -docstring ''

		map global prompt  <a-d>               '<c-r>'                                 -docstring ''
		map global prompt  <a-s-d>             '<c-v>'                                 -docstring ''

		map global prompt  <a-f>               '<a-semicolon>'                         -docstring ''

		# Movements
		map global prompt  <left>              '<left>'                                -docstring ''
		map global prompt  <right>             '<right>'                               -docstring ''
		map global prompt  <up>                '<up>'                                  -docstring ''
		map global prompt  <down>              '<down>'                                -docstring ''
		map global prompt  <home>              '<home>'                                -docstring ''
		map global prompt  <end>               '<end>'                                 -docstring ''
		map global prompt  <c-left>            '<a-b>'                                 -docstring ''
		map global prompt  <c-right>           '<a-e><right>'                          -docstring ''

		map global prompt  <tab>               '<tab>'                                 -docstring ''
		map global prompt  <s-tab>             '<s-tab>'                               -docstring ''

		map global prompt  <a-j>               '<left>'                                -docstring ''
		map global prompt  <a-l>               '<right>'                               -docstring ''
		map global prompt  <a-i>               '<up>'                                  -docstring ''
		map global prompt  <a-k>               '<down>'                                -docstring ''

		map global prompt  <a-u>               '<a-b>'                                 -docstring ''
		map global prompt  <a-o>               '<a-e><right>'                          -docstring ''
		map global prompt  <a-s-u>             '<a-s-b>'                               -docstring ''
		map global prompt  <a-s-o>             '<a-s-e><right>'                        -docstring ''

		map global prompt  <a-n>               '<tab>'                                 -docstring ''
		map global prompt  <a-s-n>             '<s-tab>'                               -docstring ''

		# Actions
		map global prompt  <backspace>         '<backspace>'                           -docstring ''
		map global prompt  <del>               '<del>'                                 -docstring ''

		# Environments
		map global prompt  <a-e>               '<c-o>'                                 -docstring ''
		map global prompt  <a-s-e>             '<a-!>'                                 -docstring ''

	# Goto
	map global Goto    <g>                 '<g><g>'                                -docstring 'buffer top'
	map global Goto    <s-g>               '<g><j>'                                -docstring 'buffer bottom'

	map global Goto    <j>                 '<a-t>'                                 -docstring 'occurrence left until'
	map global Goto    <l>                 '<t>'                                   -docstring 'occurrence right until'
	map global Goto    <s-j>               '<a-f>'                                 -docstring 'occurrence left to'
	map global Goto    <s-l>               '<f>'                                   -docstring 'occurrence right to'

	map global Goto    <i>                 '<g><g>'                                -docstring 'buffer top'
	map global Goto    <k>                 '<g><e>'                                -docstring 'buffer end'
	map global Goto    <s-i>               '<g><t>'                                -docstring 'window top'
	map global Goto    <s-k>               '<g><b>'                                -docstring 'window bottom'

	map global Goto    <u>                 '<c-u>'                                 -docstring 'half page up'
	map global Goto    <o>                 '<c-d>'                                 -docstring 'half page down'
	map global Goto    <s-u>               '<c-b>'                                 -docstring 'page up'
	map global Goto    <s-o>               '<c-f>'                                 -docstring 'page down'

	map global Goto    <h>                 '<*>'                                   -docstring 'auto search'
	map global Goto    <s-h>               '<a-*>'                                 -docstring 'pattern search'

	map global Goto    <n>                 '<c-o>'                                 -docstring 'jump backward'
	map global Goto    <s-n>               '<c-i>'                                 -docstring 'jump forward'

	map global Goto    <s>                 '<%>'                                   -docstring 'select whole buffer'

	map global Goto    <d>                 '<g><f>'                                -docstring 'file'
	map global Goto    <f>                 '<g><a>'                                -docstring 'last buffer'
	map global Goto    <e>                 '<g><.>'                                -docstring 'last buffer change'
	map global Goto    <s-d>               '<g><c>'                                -docstring 'window center'

	map global Goto    <.>                 '<c-s>'                                 -docstring 'save selections'

	# Exto
	map global Exto    <g>                 '<s-g><g>'                              -docstring 'buffer top'
	map global Exto    <s-g>               '<s-g><j>'                              -docstring 'buffer bottom'

	map global Exto    <j>                 '<a-s-t>'                               -docstring 'occurrence left until'
	map global Exto    <l>                 '<s-t>'                                 -docstring 'occurrence right until'
	map global Exto    <s-j>               '<a-s-f>'                               -docstring 'occurrence left to'
	map global Exto    <s-l>               '<s-f>'                                 -docstring 'occurrence right to'

	map global Exto    <i>                 '<s-g><g>'                              -docstring 'buffer top'
	map global Exto    <k>                 '<s-g><e>'                              -docstring 'buffer end'
	map global Exto    <s-i>               '<s-g><t>'                              -docstring 'window top'
	map global Exto    <s-k>               '<s-g><b>'                              -docstring 'window bottom'

	map global Exto    <u>                 '<c-u>'                                 -docstring 'half page up'
	map global Exto    <o>                 '<c-d>'                                 -docstring 'half page down'
	map global Exto    <s-u>               '<c-b>'                                 -docstring 'page up'
	map global Exto    <s-o>               '<c-f>'                                 -docstring 'page down'

	map global Exto    <h>                 '<*>'                                   -docstring 'auto search'
	map global Exto    <s-h>               '<a-*>'                                 -docstring 'pattern search'

	map global Exto    <n>                 '<c-o>'                                 -docstring 'jump backward'
	map global Exto    <s-n>               '<c-i>'                                 -docstring 'jump forward'

	map global Exto    <s>                 '<%>'                                   -docstring 'select whole buffer'

	map global Exto    <d>                 '<s-g><f>'                              -docstring 'file'
	map global Exto    <f>                 '<s-g><a>'                              -docstring 'last buffer'
	map global Exto    <e>                 '<s-g><.>'                              -docstring 'last buffer change'
	map global Exto    <s-d>               '<s-g><c>'                              -docstring 'window center'

	map global Exto    <.>                 '<c-s>'                                 -docstring 'save selections'

	# View
	map global View    <space>             '<v><c>'                                -docstring 'center cursor'

	map global View    <j>                 '<v><h>'                                -docstring 'scroll left'
	map global View    <l>                 '<v><l>'                                -docstring 'scroll right'
	map global View    <i>                 '<v><k>'                                -docstring 'scroll up'
	map global View    <k>                 '<v><j>'                                -docstring 'scroll down'
	map global View    <s-i>               '<v><b>'                                -docstring 'scroll UP'
	map global View    <s-k>               '<v><t>'                                -docstring 'scroll DOWN'

	map global View    <u>                 '<c-u>'                                 -docstring 'half page up'
	map global View    <o>                 '<c-d>'                                 -docstring 'half page down'
	map global View    <s-u>               '<c-b>'                                 -docstring 'page up'
	map global View    <s-o>               '<c-f>'                                 -docstring 'page down'

	map global View    <d>                 '<v><m>'                                -docstring 'center cursor horizontally'
	map global View    <s-d>               '<v><c>'                                -docstring 'center cursor vertically'

	# VIEW
	map global VIEW    <space>             '<v><c>: view<ret>'                     -docstring 'center cursor'

	map global VIEW    <j>                 '<v><h>: view<ret>'                     -docstring 'scroll left'
	map global VIEW    <l>                 '<v><l>: view<ret>'                     -docstring 'scroll right'
	map global VIEW    <i>                 '<v><k>: view<ret>'                     -docstring 'scroll up'
	map global VIEW    <k>                 '<v><j>: view<ret>'                     -docstring 'scroll down'
	map global VIEW    <s-i>               '<v><b>: view<ret>'                     -docstring 'scroll UP'
	map global VIEW    <s-k>               '<v><t>: view<ret>'                     -docstring 'scroll DOWN'

	map global VIEW    <u>                 '<c-u>: view<ret>'                      -docstring 'half page up'
	map global VIEW    <o>                 '<c-d>: view<ret>'                      -docstring 'half page down'
	map global VIEW    <s-u>               '<c-b>: view<ret>'                      -docstring 'page up'
	map global VIEW    <s-o>               '<c-f>: view<ret>'                      -docstring 'page down'

	map global VIEW    <d>                 '<v><m>: view<ret>'                     -docstring 'center cursor horizontally'
	map global VIEW    <s-d>               '<v><c>: view<ret>'                     -docstring 'center cursor vertically'

	# Combine
	map global Combine <d>                 '<a-z><i>'                              -docstring 'intersection'
	map global Combine <f>                 '<a-z><a>'                              -docstring 'append lists'
	map global Combine <e>                 '<a-z><u>'                              -docstring 'union'

	map global Combine <j>                 '<a-z><lt>'                             -docstring 'select leftmost cursor'
	map global Combine <l>                 '<a-z><gt>'                             -docstring 'select rightmost cursor'

	map global Combine <s>                 '<a-z><plus>'                           -docstring 'select longest'
	map global Combine <a>                 '<a-z><minus>'                          -docstring 'select shortest'

	# Combire
	map global Combire <d>                 '<a-s-z><i>'                            -docstring 'intersection'
	map global Combire <f>                 '<a-s-z><a>'                            -docstring 'append lists'
	map global Combire <e>                 '<a-s-z><u>'                            -docstring 'union'

	map global Combire <j>                 '<a-s-z><lt>'                           -docstring 'select leftmost cursor'
	map global Combire <l>                 '<a-s-z><gt>'                           -docstring 'select rightmost cursor'

	map global Combire <s>                 '<a-s-z><plus>'                         -docstring 'select longest'
	map global Combire <a>                 '<a-s-z><minus>'                        -docstring 'select shortest'

	# Replace
	map global Replace <space>             '<@>'                                   -docstring 'convert tabs to spaces'
	map global Replace <tab>               '<a-@>'                                 -docstring 'convert spaces to tabs'
	map global Replace <v>                 '<s-r>'                                 -docstring 'replace with yanked text'
	map global Replace <s-v>               '<a-s-r>'                               -docstring 'replace with every yanked text'

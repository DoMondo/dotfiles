" Vim color file
" Based on:
" Lars H. Nielsen (dengmao@gmail.com)

set background=dark

if version > 580
 hi clear
 if exists("syntax_on")
 syntax reset
 endif
endif

let colors_name = "wombat"

" General colors
hi Normal guifg=#EEEEEE guibg=#212121 gui=none
hi Cursor guifg=#242424 guibg=#eae788 gui=none
hi Visual guifg=#c3c6ca guibg=#554d4b gui=none
hi VisualNOS guifg=#c3c6ca guibg=#303030 gui=none
hi Search guifg=#FFFFFF guibg=#660000 gui=none
hi Folded guifg=#a0a8b0 guibg=#3a4046 gui=none
hi Title guifg=#ffffd7 gui=bold
hi StatusLine guifg=#ffffd7 guibg=#444444 gui=none
hi VertSplit guifg=#444444 guibg=#444444 gui=none
hi StatusLineNC guifg=#857b6f guibg=#444444 gui=none
hi LineNr guifg=#808080 guibg=#080808 gui=none
hi SpecialKey guifg=#626262 guibg=#2b2b2b gui=none
hi WarningMsg guifg=#ff5f55
hi ErrorMsg guifg=#e3e0d7 guibg=#3a3a3a gui=bold
hi SpellBad guifg=#e3e0d7 guibg=#3a3a3a gui=bold
hi SpellCap guifg=#e3e0d7 guibg=#3a3a3a gui=bold

" Vim >= 7.0 specific colors
if version >= 700
hi CursorLine guibg=#32322f
hi MatchParen guifg=#eae788 guibg=#857b6f gui=bold
hi Pmenu guifg=#ffffd7 guibg=#444444
hi PmenuSel guifg=#080808 guibg=#cae982
endif

" Diff highlighting
hi DiffAdd guibg=#274D28
hi DiffDelete  guifg=#909090 guibg=#B60000 gui=none
hi DiffText guifg=#000000 gui=none
hi DiffChange guibg=#271A72

" Syntax highlighting
hi Keyword guifg=#8AC6F2 gui=none
hi Statement guifg=#8AC6F2 gui=none
hi Constant guifg=#F08080 gui=none
hi Number guifg=#F08080 gui=none
hi PreProc guifg=#9C3EA4 gui=none
hi Function guifg=#00FFF9 gui=none
hi Identifier guifg=#8AC6F2  gui=none
hi Type guifg=#8AC6F2 gui=none
hi Special guifg=#eadead gui=none
hi String guifg=#95e454 gui=none
hi Comment guifg=#808080 gui=italic
hi Todo guifg=#857b6f guibg=#101000

hi Occurrence guifg=#009000 guibg=#212121 

" Links
hi! link FoldColumn Folded
hi! link CursorColumn CursorLine
hi! link NonText LineNr

" Awesome 80 characters delemiter
execute "set colorcolumn=" . join(range(81,335), ',')
hi ColorColumn guibg=#262626 

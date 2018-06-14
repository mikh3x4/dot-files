
colo molokai
"syn match dFunction "\<\k\+\ze("
"syn match dFunction "\zs\(\k\w*\)*\s*\ze("
syntax match dFuncCall /\k\+\%(\s*(\)\@=/
"hi link dFunction Function
hi dFuncCall ctermfg=81
hi dFuncCall guifg=#5fd7ff

syntax keyword pythonSelf self
hi pythonSelf ctermfg=166
hi pythonSelf guifg=#d75f00

syntax keyword pythonBuiltin print len
hi pythonBuiltin ctermfg=161
hi pythonBuiltin guifg=#F92772


hi Visual ctermbg=240
hi Visual guibg=#585858
hi VisualNOS ctermbg=240
hi VisualNOS guibg=#585858

hi String ctermfg=221
hi String guifg=#E6DC6D
"syn region FCall start='[[:alpha:]_]\i*\s*(' end=')' contains=FCall,FCallKeyword
"syn match FCallKeyword /\i*\ze\s*=[^=]/ contained
"hi FCallKeyword ctermfg=141

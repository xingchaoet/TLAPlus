" Vim indent file
" Language:         tla+ 
" Maintainer:      xingchao xingchao19811209@gmail.com 
" Latest Revision: 14/01/2013 03:57:01 星期一
"

if exists("b:did_indent")
  finish
endif
let b:did_indent = 1


setlocal indentexpr=GetTLAIndent()
setlocal indentkeys=*<CR>,!^F,o,O,=$THEN,=$ELSE 
setlocal nosmartindent 

if exists("*GetTLAIndent")
  finish
endif

function GetTLAIndent()
  " let lastline=getline(a:lnum-1)
  " if a:lnum==1 
  " return 0 
  " endif


  let lnum = prevnonblank(v:lnum - 1)
  if lnum == 0
    return 0
  endif
  let ind = indent(lnum)
  let indsave = ind
  "indent at next line , if prevnonblank line match 
  if getline(lnum) =~ '^\s*\(IF\|THEN\|ELSE\|LET\|IN\|CASE\)\>'
    let ind = ind + &sw
  endif

  if getline(lnum) =~ '\w\s*\(==\|:\)\s*'
    let ind = ind + &sw
  endif

  let previfline = search('IF','bW') 
  let previflineindent = indent(previfline)
  if getline(v:lnum) =~ 'ELSE'
    let ind = previflineindent
  endif

  let prevcasesquareline = search('\[\]','bW') 
  "first [] indent follow the CASE
  if getline(lnum) =~ '^\s*\(CASE\)\>'
    "other []s follow the prev []
  else
    let prevcasesquarelineindent = indent(prevcasesquareline)
    if getline(v:lnum) =~ '\[\]'
      let ind = prevcasesquarelineindent
    endif
  endif
  "\/ 
  let prevdisconjunctionline = search('\(\\)\@<=\/','bW') 
  " let prevdisconjunctionline = search('\(\\)\@<=\/','bW') 
  if getline(lnum) =~ '^\s*\(LET\)\>'
  else
    let prevdisconjunctionlineindent = indent(prevdisconjunctionline)
    if getline(v:lnum) =~ '\(\\)\@<=\/'
      " if getline(v:lnum) =~ '\(\\)\@<=\/'
      let ind = prevdisconjunctionlineindent
    endif
  endif

  "vim do not search /
  "/\
  let prevconjunctionline = search('\[/\]','bW') 
  if getline(lnum) =~ '^\s*\(LET\)\>'
  else
    let prevconjunctionlineindent = indent(prevconjunctionline)
    if getline(v:lnum) =~ '\[/\]'
      let ind = prevconjunctionlineindent
    endif
  endif
  "defination
  if getline(v:lnum) =~ '\s*\w\s*\(==\|:\)\s*'
    let  ind = 0 
  endif
  " "----
  " if getline(v:lnum) =~ '\s*\(-\)\{0,4}\s*$'
    " let  ind = 0 
  " endif
  " "====
  " if getline(v:lnum) =~ '\s*\(=\)\{0,4}\s*$'
    " let  ind = 0 
  " endif

  return ind


  " if getline(a:lnum)=~'^\s*THEN\s*$'
  " let diff=1
  " elseif lastline=~'^\s*[*+]'
  " let diff=0
  " elseif lastline=~'^\s*-\s*$'
  " let diff=-1
  " elseif lastline=~'^\s*-\s*\S'
  " let diff=1
  " endif 

  " return indent(a:lnum-1)+diff*&sw
endfunc


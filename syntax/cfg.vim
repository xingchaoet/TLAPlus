" tla.vim
" @Author:      xingchao <xingchao19811209@gmail.com>
" @Website:     http://www.vim.org/account/profile.php?user_id=4037
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Created:     Mon Apr 30 18:03:51 CST 2012.
" @Last Change: 
" @Revision:    0.1

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

let	s:MSWIN =		has("win16") || has("win32") || has("win64") || has("win95")
if s:MSWIN
    let s:plugin_dir							= $VIM.'\vimfiles\'
  "  g:CFG_Dictionary_File  must be global
  if !exists("g:CFG_Dictionary_File")
    let g:CFG_Dictionary_File     = s:plugin_dir.'tla-support\wordlists\cfg.list'
  endif

else
    let s:plugin_dir							= $VIM.'/.vim/'
  "  g:CFG_Dictionary_File  must be global
  if !exists("g:CFG_Dictionary_File")
    let g:CFG_Dictionary_File     = s:plugin_dir.'tla-support/wordlists/cfg.list'
  endif
endif


"
" ---------- CFG dictionary -----------------------------------
"
" This will enable keyword completion for tla
if exists("g:CFG_Dictionary_File")
  let save=&dictionary
  silent! exe 'setlocal dictionary='.g:CFG_Dictionary_File
  silent! exe 'setlocal dictionary+='.save
endif


syn keyword tlaSingularKW		 SPECIFICATION   INIT NEXT VIEW SYMMETRY 
syn keyword tlaPlurarKW		 CONSTRAINTS CONSTRAINT ACTION-CONSTRAINTS  ACTION-CONSTRAINT INVARIANT   INVARIANTS PROPERTY PROPERTIES  
syn keyword tlaOtherKW CONSTANTS CONSTANT  
syn match tlaOperator  /[=|{|}|,|\-|<|>]/ 
" syn match tlaOperator1  /=/ 
" syn match tlaOperator2  /{/ 
" syn match tlaOperator3  /}/  
" syn match tlaOperator4  /,/ 
syntax match tlaComment /(\*\(.\)*\*)/
" syntax match tlaComment /(\*\(\_.\)*\*)/
syntax match tlaSlashComment /\\\*.*/
syntax region tlaString  start=/"/ skip=/\\"/ end=/"/
if version >= 508 
  if version < 508
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink tlaOtherKW Identifier
  HiLink tlaComment Comment
  HiLink tlaSlashComment Comment
  HiLink tlaString String
  HiLink tlaOperator Operator 
  " HiLink tlaOperator1 Operator 
  " HiLink tlaOperator2 Operator 
  " HiLink tlaOperator3 Operator 
  " HiLink tlaOperator4 Operator 

  hi def tlaSingularKW		 cterm=bold ctermfg=Cyan ctermbg=darkgrey guifg=DarkBlue gui=Bold,Italic
  hi def tlaPlurarKW		 ctermfg=DarkBlue guifg=DarkBlue 

  delcommand HiLink
endif

let b:current_syntax = "cfg"


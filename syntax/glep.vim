" Vim syntax file
" Language:	Funtoo GLEPs
" Author:	Ciaran McCreesh <ciaranm@gentoo.org>
" Copyright:	Copyright (c) 2004-2005 Ciaran McCreesh
" Licence:	You may redistribute this under the same terms as Vim itself
"
" Syntax highlighting for Funtoo GLEPs. Needs vim 6.3 or later. Inherits from
" rst.vim and provides a few extras.
"
" ported to Funtoo by Martin 'golodhrim' Scholz <golodhrim@funtoo.org>
"

if &compatible || v:version < 603
    finish
endif

if exists("b:current_syntax")
  finish
endif

runtime! syntax/rst.vim
unlet b:current_syntax

" Headings in GLEPs (rst doesn't highlight these)
syn match  glepHeading1 /^\(\(-\{2,\}\|=\{2,\}\|'\{2,\}\)\n\)\S.\+\n\(-\{2,\}\|=\{2,\}\|'\{2,\}\)$/
syn match  glepHeading2 /^\S.\+\n=\{2,\}$/
syn match  glepHeading3 /^\S.\+\n-\{2,\}$/
syn match  glepHeading4 /^\S.\+\n'\{2,\}$/
syn match  glepHeading5 /^\S.\+\n\^\{2,\}$/

" Folding
syn region glepFoldH2 start=/^\S.\+\n=\{2,\}$/ end=/\(\n\n\S.\+\n=\{2,\}\)\@=/ transparent fold
syn region glepFoldH3 start=/^\S.\+\n-\{2,\}$/ end=/\(\n\n\S.\+\n[-=]\{2,\}\)\@=/ transparent fold
syn region glepFoldH4 start=/^\S.\+\n'\{2,\}$/ end=/\(\n\n\S.\+\n[-=']\{2,\}\)\@=/ transparent fold

" Headers at the top of a GLEP
syn region glepHeaders start=/\%^\(.*:\)\@=/ end=/^$/ contains=glepHeaderKey
syn region glepHeaderKey contained start=/^[A-Za-z0-9]/ end=/:/ nextgroup=glepHeaderValue skipwhite
syn region glepHeaderValue contained start=/\S/ end=/$/ contains=glepHeaderEmail,glepHeaderCVSVar
syn match  glepHeaderEmail contained /<[-a-zA-Z0-9\_\.]\+@[-a-zA-Z0-9\_\.]\+>/
syn region glepHeaderCVSVar contained start=/\$\S\+:/ end=/\$/
syn keyword glepTODO TODO FIXME

syn match rstInline /|\S\+|/

hi! link rstInline          PreProc
hi! link rstInternalTarget  PreProc

hi  link glepHeading1       Title
hi  link glepHeading2       Constant
hi  link glepHeading3       Keyword
hi  link glepHeading4       Preproc
hi  link glepHeading5       Special

hi  link glepHeaders        Define
hi  link glepHeaderKey      Keyword
hi  link glepHeaderValue    String
hi  link glepHeaderEmail    Special
hi  link glepHeaderCVSVar   PreProc
hi  link glepTODO           Todo

let b:current_syntax = "glep"


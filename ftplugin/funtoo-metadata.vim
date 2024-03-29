" Vim filetype plugin file
" Language:	Funtoo metadata.xml
" Author:	Ciaran McCreesh <ciaranm@gentoo.org>
" Copyright:	Copyright (c) 2004-2005 Ciaran McCreesh
" Licence:	You may redistribute this under the same terms as Vim itself
"
" This sets up filetype specific options for Funtoo metadata.xml files.
"
" ported to Funtoo by Martin 'golodhrim' Scholz <golodhrim@funtoo.org>
"

if &compatible || v:version < 603
    finish
endif

runtime! ftplugin/xml.vim

" Required whitespace settings
setlocal tabstop=4
setlocal shiftwidth=4
setlocal noexpandtab
setlocal textwidth=80

" GLEP 31 settings
setlocal fileencoding=utf-8


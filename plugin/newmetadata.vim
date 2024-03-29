" Vim plugin
" Purpose:      Intelligently create content for metadata.xml
" Author:       Ciaran McCreesh <ciaranm@gentoo.org>
" Copyright:    Copyright (c) 2004-2005 Ciaran McCreesh
" Licence:      You may redistribute this under the same terms as Vim itself
"
" ported to Funtoo by Martin 'golodhrim' Scholz <golodhrim@funtoo.org>
"

if &compatible || v:version < 603 || exists("g:loaded_newmetadata")
    finish
endif

let g:loaded_newmetadata=1

runtime! plugin/funtoo-common.vim

fun! <SID>MakeNewMetadata()
    let l:pastebackup = &paste
    set nopaste

    " {{{ variables
    let l:filename = expand("%:p")
    let l:dir = expand("%:p:h")

    if glob(l:dir . '/*/*.ebuild') =~ '\S'
        let l:category = substitute(l:filename, '^.*/\([a-z][a-z0-9]\+-[a-z]\+\)/metadata.xml$',
                    \ '\1', '')
        let l:iscatmetadata = 1
    else
        let l:category = substitute(l:filename,
                    \ "^.*/\\([^/]\\+\\)/[^/]\\+/metadata\\.xml", "\\1", "g")
        let l:iscatmetadata = 0
        let l:user = FuntooGetUser()
        let l:email = matchstr(l:user, "\\(<\\)\\@<=[^>]\\+\\(>\\)\\@=")
        let l:name = matchstr(l:user, "^[^<]\\+\\( <\\)\\@=")
    endif
    " }}}

    " {{{ catmetadata
    if l:iscatmetadata
        " {{{ content
        0 put ='<?xml version=\"1.0\" encoding=\"UTF-8\"?>'
        put ='<!DOCTYPE catmetadata SYSTEM \"http://www.gentoo.org/dtd/metadata.dtd\">'
        put ='<catmetadata>'
        put ='<longdescription lang=\"en\">'
        put ='</longdescription>'
        put ='</catmetadata>'
        exec "normal gg=G"
        " }}}
    " }}}
else
    " {{{ pkgmetadata

        " {{{ herd
        let l:herd = "no-herd"
        if l:category ==# "app-vim"
            let l:herd = "vim"
        elseif l:category ==# "dev-perl"
            let l:herd = "perl"
        elseif l:category ==# "dev-ruby"
            let l:herd = "ruby"
        elseif l:category ==# "dev-tex"
            let l:herd = "text-markup"
        elseif l:category ==# "dev-java"
            let l:herd = "java"
        endif
        " }}}

        " {{{ content
        0 put ='<?xml version=\"1.0\" encoding=\"UTF-8\"?>'
        put ='<!DOCTYPE pkgmetadata SYSTEM \"http://www.gentoo.org/dtd/metadata.dtd\">'
        put ='<pkgmetadata>'
        put ='<herd>' . l:herd . '</herd>'
        if l:email != "" || l:name != ""
            put ='<maintainer>'
            if l:email != ""
                put ='<email>' . l:email . '</email>'
            endif
            if l:name != ""
                put ='<name>' . l:name . '</name>'
            endif
	    put ='</maintainer>'
        endif
        put ='<longdescription lang=\"en\">'
        put ='</longdescription>'
        put ='</pkgmetadata>'
        exec "normal gg=G"
        " }}}
    endif
    " }}}

    if pastebackup == 0
        set nopaste
    endif
endfun

com! -nargs=0 NewMetadata call <SID>MakeNewMetadata()
augroup NewMetadata
    au!
    autocmd BufNewFile metadata.xml
                \ call <SID>MakeNewMetadata()
augroup END

" vim: set et foldmethod=marker : "

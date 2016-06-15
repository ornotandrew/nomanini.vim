" Helper functions
function! nomanini#is_nomanini_repo(path)
    let l:dirs = split(fnamemodify(expand(a:path), ':p'), '/')
    return index(dirs, g:nomanini_repo_name) != -1
endfunction

function! nomanini#get_single_path(path)
    let l:dirs = split(expand(a:path), '/')
    let l:func_index = index(dirs, 'functional')
    return join(dirs[l:func_index + 1:], '/')
endfunction

function! nomanini#get_module(path)
    let l:dirs = split(fnamemodify(expand(a:path), ':p'), '/')
    return dirs[index(dirs, 'src')+1]
endfunction

function! nomanini#get_makefile_path(path)
    let l:dirs = split(fnamemodify(expand(a:path), ':p'), '/')
    let l:root_index = index(dirs, g:nomanini_repo_name)
    return '/'.join(dirs[:l:root_index], '/').'/makefile'
endfunction

function! nomanini#set_makeprg(type)
    let l:make_string = 'make -f '.nomanini#get_makefile_path('%')
    if a:type ==# 'single'
        let l:make_string .= ' '.nomanini#get_module('%').' SINGLE='.nomanini#get_single_path('%')
    elseif a:type ==# 'module'
        let l:make_string .= ' '.nomanini#get_module('%')
    endif
    let l:make_string .= ' EXTRA_NOSE_ARGS='
    let &makeprg = l:make_string
endfunction

function! nomanini#set_errorformat()
    let &errorformat = '%C %.%#,%A  File "%f"\, line %l%.%#,%Z%[%^ ]%\@=%m'
endfunction

function! nomanini#test(type)
    if nomanini#is_nomanini_repo('%')
        if exists('g:nomanini_nose_path') && exists('g:nomanini_gae_path')
            let l:old_makeprg = &makeprg
            let l:old_efm = &errorformat
            call nomanini#set_makeprg(a:type)
            call nomanini#set_errorformat()
            execute g:nomanini_make_command
            let &makeprg = l:old_makeprg
            let &errorformat = l:old_efm
        else
            echom 'You need to define g:nomanini_nose_path and g:nomanini_gae_path'
        endif
    else
        echom 'You are not in the nomanini repo'
    endif
endfunction


" Helper functions
function! nomanini#is_nomanini_repo(path)
    let l:dirs = split(fnamemodify(expand(a:path), ':p'), '/')
    return index(dirs, g:nomanini_repo_name) != -1
endfunction

function! nomanini#get_repo_root(path)
    let l:dirs = split(fnamemodify(expand(a:path), ':p'), '/')
    let l:repo_index = index(dirs, g:nomanini_repo_name)
    return '/'.join(dirs[:l:repo_index], '/')
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
    let l:make_string .= ' EXTRA_NOSE_ARGS=--with-machineout'
    let &makeprg = l:make_string
endfunction

function! nomanini#set_errorformat()
    let &errorformat = '%f:%l: fail: %m,%f:%l: error: %m'
endfunction

function! nomanini#test(type)
    if nomanini#is_nomanini_repo('%')
        let l:old_makeprg = &makeprg
        let l:old_efm = &errorformat
        let l:old_cwd = getcwd()
        call nomanini#set_makeprg(a:type)
        call nomanini#set_errorformat()
        execute 'cd ' nomanini#get_repo_root('%')
        execute g:nomanini_make_command
        let &makeprg = l:old_makeprg
        let &errorformat = l:old_efm
        execute 'cd ' l:old_cwd
    else
        echom 'You are not in the nomanini repo'
    endif
endfunction


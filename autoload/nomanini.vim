" Helper functions to parse paths
function! nomanini#is_nomanini_repo(path)
    let l:dirs = split(fnamemodify(expand(a:path), ':p'), '/')
    return index(dirs, g:nomanini_repo_name) != -1
endfunction

function! nomanini#get_single_path(path)
    let l:dirs = split(expand(a:path), '/')
    return join(dirs[-2:], '/')
endfunction

function! nomanini#get_module_path(path)
    let l:dirs = split(fnamemodify(expand(a:path), ':p'), '/')
    let l:modPath = dirs[:index(dirs, 'src')+1]
    return '/'.join(modPath, '/')
endfunction

function! nomanini#get_module_yaml(path)
    let l:dirs = split(expand(a:path), '/')
    let l:yaml = dirs[index(dirs, 'src')+1]
    " oldserver is the default module -> has app.yaml
    if l:yaml ==# 'oldserver'
        let l:yaml = 'app'
    endif
    return nomanini#get_module_path(a:path).'/'.l:yaml.'.yaml'
endfunction

function! nomanini#set_makeprg()
	if exists('g:nomanini_nose_path') && exists('g:nomanini_gae_path')
        exec 'setlocal makeprg='.expand(g:nomanini_nose_path).
             \'\ -v\ tests/functional/'.nomanini#get_single_path('%').
             \'\ -w\ '.nomanini#get_module_path('%').
             \'\ --logging-filter=-root'.
             \'\ --processes='.g:nomanini_nose_processes.
             \'\ --process-timeout='.g:nomanini_nose_process_timeout.
             \'\ --with-gae'.
             \'\ --gae-lib-root='.g:nomanini_gae_path.
             \'\ --gae-application='.nomanini#get_module_yaml('%')
    else
        echo 'You need to define g:nomanini_nose_path and g:nomanini_gae_path'
    endif
endfunction

function! nomanini#set_errorformat()
    setlocal errorformat=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
endfunction


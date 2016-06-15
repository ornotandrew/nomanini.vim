" Globals and commands for the nomanini plugin
if exists("g:loaded_nomanini")
  finish
endif
let g:loaded_nomanini = 1

" Globals that need to be set
" g:nomanini_nose_path
" g:nomanini_gae_path

" Globals that may be overridden
if !exists('g:nomanini_repo_name')
    let g:nomanini_repo_name = 'nomanini-backend'
endif
if !exists('g:nomanini_nose_processes')
    let g:nomanini_nose_processes = 4
endif
if !exists('g:nomanini_nose_process_timeout')
    let g:nomanini_nose_process_timeout = 600
endif
if !exists('g:nomanini_make_command')
    let g:nomanini_make_command = 'make'
endif

" Commands
command Test call nomanini#test('all')
command TestModule call nomanini#test('module')
command TestSingle call nomanini#test('single')

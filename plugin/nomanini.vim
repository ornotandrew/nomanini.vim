" Globals for the nomanini plugin
if exists("g:loaded_nomanini")
  finish
endif
let g:loaded_nomanini = 1

" Globals that should be overridden
" g:nomanini#nose_path
" g:nomanini#gae_path

" Globals that may be overridden
let g:nomanini#repo_name = 'nomanini-backend'
let g:nomanini#nose_processes = 4
let g:nomanini#nose_process_timeout = 600


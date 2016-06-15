# About
This plugin sets up `makeprg` and `errorformat` for running nosetests on the nomanini codebase.  
This is a thin wrapper around the makefile, and simply sets up the correct arguments and variables.

# Usage
First, define the following globals in your `.vimrc`

```VimL
g:nomanini_nose_path = '/path/to/nosetests'
g:nomanini_gae_path = '/path/to/google_appengine'
```

Then run one of the following

`:TestSingle` - Run a single test
`:TestModule` - Run tests for the entire module that the current file belongs to
`:Test` - Run all the tests for all modules

# Configuration
You can specify the following options

| Variable                          | Default              | Description                                                            |
| --------------------------------- | -------------------- | ---------------------------------------------------------------------- |
| `g:nomanini_repo_name`            | `'nomanini‑backend'` | Used when detecting if the current python file is in the Nomanini repo |
| `g:nomanini_nose_processes`       | `4`                  | The number of nose processes to run concurrently                       |
| `g:nomanini_nose_process_timeout` | `600`                | The timeout (in seconds) for each nose process                         |
| `g:nomanini_make_command`         | `'make'`             | The vim command to execute when running tests                          |
 
For example, to run the tests with [Neomake](https://github.com/benekastah/neomake)

```VimL
let g:nomanini_make_command = 'Neomake!'
```

# About
This plugin sets up `makeprg` and `errorformat` for running nosetests on the nomanini codebase.  
Arguments, such as paths to the current Google Appengine module and `.yaml` file, are set up based on the path of the test file.

# Usage
Define the following globals

```VimL
g:nomanini_nose_path = '/path/to/nosetests'
g:nomanini_gae_path = '/path/to/google_appengine'
```

Run `:TestSingle`

# Configuration
The following extra options are exposed

| Variable                          | Default              | Description                                                            |
| --------------------------------- | -------------------- | ---------------------------------------------------------------------- |
| `g:nomanini_repo_name`            | `'nomanini-backend'` | Used when detecting if the current python file is in the Nomanini repo |
| `g:nomanini_nose_processes`       | `4`                  | The number of nose processes to run concurrently                       |
| `g:nomanini_nose_process_timeout` | `600`                | The timeout (in seconds) for each nose process                         |
| `g:nomanini_make_command`         | `'make'`             | The command to execute when running `:TestSingle`                      |
 
For example, to run the tests with [Neomake](https://github.com/benekastah/neomake)

```VimL
let g:nomanini_make_command = 'Neomake!'
```

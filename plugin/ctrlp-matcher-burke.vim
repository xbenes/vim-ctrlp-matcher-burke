" Use custom matcher for ctrl+p plugin, if path_to_matcher provided and executable
" Compile https://github.com/burke/matcher and specify binary

if exists("g:ctrlp_matcher_burke_loaded")
  finish
endif

let g:ctrlp_matcher_burke_loaded = 1

" nothing to do if matcher path not specified
if !exists("g:path_to_matcher")
    finish
endif

" nothing to do if matcher specified but not executable
if !executable(g:path_to_matcher)
    finish
endif

" matcher binary was specified and is executable, proceed to override ctrlp default behaviour
" source: https://github.com/burke/matcher/blob/master/README.md, section "Using with CtrlP.vim"
let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files . -co --exclude-standard']
let g:ctrlp_match_func = { 'match': 'GoodMatch' }
function! GoodMatch(items, str, limit, mmode, ispath, crfile, regex)
    " Create a cache file if not yet exists
    let cachefile = ctrlp#utils#cachedir().'/matcher.cache'
    if !( filereadable(cachefile) && a:items == readfile(cachefile) )
        call writefile(a:items, cachefile)
    endif
    if !filereadable(cachefile)
        return []
    endif

    " a:mmode is currently ignored. In the future, we should probably do
    " something about that. the matcher behaves like "full-line".
    let cmd = g:path_to_matcher.' --limit '.a:limit.' --manifest '.cachefile.' '
    if !( exists('g:ctrlp_dotfiles') && g:ctrlp_dotfiles )
        let cmd = cmd.'--no-dotfiles '
    endif
    let cmd = cmd.a:str

    return split(system(cmd), "\n")
endfunction

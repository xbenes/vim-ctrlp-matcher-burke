# vim-ctrlp-matcher-burke

use 'burke/matcher' as matching engine for ctrlp

## Description
This plugin just contains the preferred way to integrate matcher to vim as described in
https://github.com/burke/matcher

## Installation
1. Compile matcher binary from https://github.com/burke/matcher and store it somewhere (e.g. /usr/local/bin/matcher)

2. Using [vim-plug](https://github.com/junegunn/vim-plug):

```vim
Plug 'xbenes/vim-ctrlp-matcher-burke'
```

3. Provide matcher path to where you stored the compiled binary (in step 1)
```vim
let g:path_to_matcher = '/usr/local/bin/matcher'
```


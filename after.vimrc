" plugin globals
"let g:clang_complete_loaded=1
"let g:indentLine_setColors = 0
let g:indentLine_char = '|'
let g:indentLine_indentLevel = 2
let g:indentLine_showFirstIndentLevel = 0
let g:ackprg = 'ag --nogroup --nocolor --column --ignore tags --vimgrep'

set nocompatible              " be iMproved, required
filetype off                  " required

"set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'Yggdroot/indentLine'
Plugin 'mileszs/ack.vim'
Plugin 'mikelue/vim-maven-plugin'
Plugin 'johngrib/vim-game-code-break'
Plugin 'johngrib/vim-game-snake'
Plugin 'rhysd/vim-clang-format'
Plugin 'scrooloose/nerdtree'
Plugin 'fatih/vim-go'

" All of your Plugins must be added before the following line
call vundle#end()            " required
"filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to
" auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

:filetype plugin indent on

:syn on                                 "syntax highlighting
:set noea                               "don't automatically resize windows
:set expandtab                          "use spaces not tabs
:set ts=4                               "tab stop.  number of spaces for tabs
:set shiftwidth=4                       "indent spaces for auto format
:set number                             "line numbers
:set bg=dark                            "set background color
:set hlsearch                           "highlight search
:set nocompatible                       "use vim not vi
:set ai                                 "auto indent
:set is                                 "inc search
:set tags+=~/.jdk_tags                  "additional tags
:set colorcolumn=120
:hi ColorColumn guibg=#4a4a4a ctermbg=0
:hi CursorLine guibg=#4a4a4a ctermbg=0
:hi Search guibg=#a4a4a4 ctermbg=27 ctermfg=0
:hi IncSearch guibg=#a4a4a4 ctermbg=27 ctermfg=0
:color molokai256                       "gvim color scheme

"indents yo
:set cin                                "use C style indentation
:setlocal cindent cino=j1,(0,ws,Ws
:set fdm=indent

"improve autocomplete menu color
:highlight Pmenu cterm=None ctermbg=Blue ctermfg=White guibg=SlateBlue guifg=White
:highlight PmenuSel ctermbg=White ctermfg=Black guibg=SlateGrey guifg=Black
:highlight SignColumn ctermbg=Grey ctermfg=Black

"Open this file
:map vrc :e ~/.oh-my-vim/after.vimrc<CR>
"Delete current buffer
:map <C-k> :bwipe<CR>
"Delete current buffer but leave window intact
:map <LOCALLEADER>q :bp<bar>sp<bar>bn<bar>bd<CR>
"Next buffer
:map <C-b> :bn<CR>
"Previous buffer
:map <C-x> :bp<CR>
"Right align visual block
:map <LEADER>ra :call RightAlignVisual()<CR>

"Remove double spaced lines
:map <LEADER>t :%s/^\s*\_$\n^\s*\_$//<CR>
"Truncate lines with only spaces or tabs
:map <LEADER>tl :%s/^[\ \t]*$//<CR>
"Remove extraneous space at end of line
:map <LEADER>trl :%s/\ *$//<CR>
"Number each line
:vmap <LEADER>ln :s/^/\=printf("%d.\t", line(".") - line("'<") + 1)<CR>

"Internatshioanale!!!
:imap <C-d><C-d> <C-R>='//$NON-NLS-1$'<CR>
:map <LEADER>nls :call InsertNLS()<CR>
"DL url
:vmap <LEADER>gu :call Get_Url()<CR>
"Add copyright
:map <LEADER>acc :call Copyright()<CR>
"Convert buffer to html
:map <LEADER>cml :runtime! syntax/2html.vim<CR>
"Maven module specific compilation
:map <LEADER>cm :call CompileModule()<CR>

:map <LEADER>- :res -5<CR>
:map <LEADER>= :res +5<CR>
:map <F3> :redir @a<CR>:g//<CR>:redir END<CR>:new<CR>:put! a<CR><CR>
:map <C-F3> :cn<CR>
:map <F4> :buffers<CR>
:map <F5> :!ctags -R . <CR>
:map <S-F5> :make -j10<CR>
:map mf :call MakeFile()<CR>
:map <F7> :VCSBlame<CR>
:map <LEADER><F7> :call ShowPatch()<CR>
:map <F9> :call SearchCodeFromBuffer()<CR>
:map <F11> :set ignorecase!<CR>
:map <LEADER><F12> :silent %!xmllint --encode UTF-8 --format -<CR>
:map <LEADER><F11> :silent %!python -m json.tool<CR>

"Move to the directory the file is located except if it is a java file
"autocmd BufEnter !java if expand("%:p:h") !~ '^/tmp' | lcd %:p:h | endif
"Auto save/load file meta
"autocmd BufWinLeave * mkview
"autocmd BufWinEnter * silent loadview

"erlang
autocmd BufRead,BufNewFile *.escript set ft=erlang
autocmd BufRead,BufNewFile *.proto set ft=proto

let g:erlangCompletionGrep='zgrep'
let g:erlangManSuffix='erl\.gz'

"ruby
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1

"go
autocmd FileType go setlocal noet
autocmd FileType go :nnoremap <buffer> <S-F5> :GoBuild<CR>
let g:go_list_type = "quickfix"

"Java
"serial version for java serializable
:map <LEADER>svi :call Insert_svi()<CR>
:map <LEADER><F8> :call JavaFindMethodInvocationsForIdentifier()<CR>
:map fd :call JavaFindDerivatives()<CR>
:map <LEADER><F9> :JavaDocComment<CR>
"Create new unit test from template
:map <LEADER>nt :call NewUnitTest()<CR>
"Add package name
:map <LEADER>pn :call PackageName()<CR>
"Get java build path for maven projects
:map <S-F10> :r! mvn dependency:build-classpath \| grep m2 \| tr ':' '\n' \| sort \| uniq \| tr '\n' ':'<CR>

function! MakeJavaCtags()
    :!ctags -R --languages=Java -f ~/.jdk_tags /usr/lib/jvm/java-8-oracle/src /Library/Java/JavaVirtualMachines/jdk1.8.0_201.jdk/Contents/Home/src
endfunction
autocmd BufNewFile,BufRead,BufEnter *.java,pom.xml :nnoremap <buffer> <F5> :call MakeJavaCtags()<CR>

autocmd FileType java :nnoremap <buffer> <S-F5> :make -DskipTests=true<CR>
autocmd FileType java setlocal cc=120
autocmd WinEnter !java setlocal cc=-1
"Java

"C/c++
function! MakeCppTags()
    :!ctags -R --languages=C,C++,Lua --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ ./src ./include target/include/amd64
endfunction
autocmd BufNewFile,BufRead,BufEnter *.c,*.h,*.cpp,*.hpp :nnoremap <buffer> <F5> :call MakeCppTags()<CR>

"Make one object from the current file
function! MakeFile()
    let l:file = fnamemodify(expand('%'), ':r') . ".o"
    :exec "make " . l:file
    unlet l:file
endfunc
"C/c++

""""""""""""" PLUGINS

"eclim
":map <LEADER>ai :JavaImport<CR>
":map <LEADER>oi :JavaImportOrganize<CR>
":map <LEADER>gs :JavaGetSet<CR>
let g:EclimProjectProblemsUpdateOnBuild=0
let g:EclimProjectProblemsUpdateOnSave=0
let g:EclimJavascriptValidate=0
let g:EclimCompletionMethod = 'omnifunc'

if !exists(":SS")
    command -nargs=? SS :call SearchCode('<args>')
endif
"eclim 

"nerd tree
:nnoremap nt :NERDTreeToggle <CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
"nerd tree

"Compilers
"autocmd FileType java compiler mvn2
autocmd FileType java compiler maven
autocmd Filetype erlang compiler erlang
autocmd FileType go compiler go
"autocmd Filetype c,h,cpp,hpp compiler gcc
"if we're using ant, then make shit happy
"autocmd Filetype c,h,cpp,hpp,java set errorformat="\ %#[%.%#]\ %#%f:%l:%v:%*\\d:%*\\d:\ %t%[%^:]%#:%m, \%A\ %#[%.%#]\ %f:%l:\ %m,%-Z\ %#[%.%#]\ %p^,%C\ %#[%.%#]\ %#%m"

"clang-format settings
let g:clang_format#code_style='llvm'
let g:clang_format#style_options = {
         \ "AccessModifierOffset" : -3,
         \ "AlignConsecutiveAssignments" : "true",
         \ "AlignConsecutiveDeclarations" : "false",
         \ "AlignTrailingComments" : "true",
         \ "AllowShortIfStatementsOnASingleLine" : "true",
         \ "AlwaysBreakTemplateDeclarations" : "false",
         \ "BreakBeforeBraces" : "Attach",
         \ "BreakConstructorInitializers" : "AfterColon",
         \ "BreakInheritanceList" : "AfterColon",
         \ "ColumnLimit" : 0,
         \ "CompactNamespaces" : "true",
         \ "ConstructorInitializerAllOnOneLineOrOnePerLine" : "false",
         \ "ConstructorInitializerIndentWidth" : 3,
         \ "ContinuationIndentWidth" : 3,
         \ "Cpp11BracedListStyle" : "true",
         \ "FixNamespaceComments" : "true",
         \ "IndentCaseLabels" : "true",
         \ "IndentWidth" : 3,
         \ "MacroBlockBegin" : "ZONOFF_SEDES_BEGIN|MSG_DEF_BEGIN",
         \ "MacroBlockEnd" : "ZONOFF_SEDES_END|MSG_DEF_END",
         \ "MaxEmptyLinesToKeep" : 1,
         \ "NamespaceIndentation" : "None",
         \ "PointerAlignment" : "Middle",
         \ "SortIncludes" : "false",
         \ "SortUsingDeclarations" : "false", 
         \ "SpaceBeforeCpp11BracedList" : "true",
         \ "SpaceBeforeCtorInitializerColon" : "true",
         \ "SpaceBeforeInheritanceColon" : "true",
         \ "SpaceBeforeParens" : "ControlStatements",
         \ "SpaceBeforeRangeBasedForLoopColon" : "true",
         \ "SpacesBeforeTrailingComments" : 3,
         \ "Standard" : "C++11"}
"\ "AllowAllConstructorInitializersOnNextLine" : "true",
"\ "AllowAllConstructorInitializersOnNextLine" : "true",
autocmd Filetype c,h,cpp,hpp :vnoremap <buffer> = :ClangFormat<CR>
autocmd Filetype c,h,cpp,hpp :setlocal ts=3
autocmd Filetype c,h,cpp,hpp :setlocal shiftwidth=3

"ycm settings
let g:ycm_confirm_extra_conf = 0
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_always_populate_location_list = 1
let g:ycm_enable_diagnostic_signs = 1
let g:ycm_enable_diagnostic_highlighting = 1
let g:ycm_autoclose_preview_window_after_insertion = 0
let g:ycm_max_diagnostics_to_display = 100

:highlight YcmErrorLine guibg=#cf0000 ctermbg=16
:highlight YcmWarningLine guibg=#cfcf00 ctermbg=130

:nnoremap <buffer> fi :YcmCompleter FixIt<CR>
:map <LEADER>ji :YcmCompleter GoToInclude<CR>
:map <LEADER>jd :YcmCompleter GoToDefinition<CR>
:map <LEADER>jc :YcmCompleter GoToDeclaration<CR>
:map <LEADER>b :call g:ClangUpdateQuickFix()<CR>

""""""""""""" PLUGINS

"Grab a git patch and display it
func! ShowPatch()
    let l:hash = expand("<cword>")

    :vnew "" . l:hash . ".patch"
    :set ft=diff
    :set cc=-1
    :set nofoldenable
    :execute "0read! git --no-pager show --pretty " . l:hash
    :normal gg

    unlet l:hash
endfunction

"Search code files
func! SearchCode(keyword)
    let l:keyword = a:keyword
    if l:keyword == ""
        echo "No keyword specified"
        return
    endif

    ":execute "vimgrep /" . l:keyword . "/jg **/*.h **/*.hpp **/*.c **/*.cpp **/*.hrl **/*.erl"
    :exec "Ack " .  l:keyword
    ":botright cwindow

    unlet l:keyword
endfunction

"Search code files from cursor
func! SearchCodeFromBuffer()
    let l:keyword = expand("<cword>")
    if l:keyword == ""
        echo "No identifier under cursor"
        return
    endif

    call SearchCode(l:keyword)

    unlet l:keyword
endfunction

" Search for method usage
func! JavaFindMethodInvocations(keyword)
    let l:keyword = a:keyword
    if l:keyword == ""
        echo "JavaFindMethodInvocations requires an argument"
        return
    endif
    let l:paths = split(@%, '/')
    let l:path = l:paths[len(l:paths)-1]

    let l:paths = split(l:path,'\.')

    if(len(l:paths) == 2 && l:paths[1]=='java')
        let l:cmd = "JavaSearch -p  " . l:paths[0] . "." . l:keyword . " -t method -x references"
        :execute l:cmd
        unlet l:cmd
    else
        echo "Not a Java file?"
    endif

    unlet l:path
    unlet l:paths
    unlet l:keyword
endfunction
" JavaFindMethodInvocations

" Search for method usage from word under cursor
func! JavaFindMethodInvocationsForIdentifier()

    let l:keyword = expand("<cword>")
    if l:keyword == ""
        echo "No identifier under cursor"
        return
    endif

    call JavaFindMethodInvocations(l:keyword)

    unlet l:keyword
endfunc
"JavaFindMethodInvocationsForIdentifier

" Find derivatives
func! JavaFindDerivatives()

    let l:keyword = expand("<cword>")
    if l:keyword == ""
        echo "No identifier under cursor"
        return
    endif

    execute "JavaSearch -p " . l:keyword . " -t class -x implementors"

    unlet l:keyword
endfunction

" Insert serialversion uuid
func! Insert_svi()

    let l:line = line('.')
    call append(l:line, "    private static final long serialVersionUID = " . strftime("%Y%m%d") . "L;")
    unlet l:line

endfunction

" Insert NLS comment at EOL
func! InsertNLS()
    let l:marker = '//$NON-NLS-1$'
    let l:linepos = line('.')
    let l:line = getline(l:linepos)
    let l:linewith = substitute(l:line, '$', ' //$NON-NLS-1$', 'g')
    call setline(l:linepos, l:linewith)
endfunction

" Insert the package name at BOF (Java)
func! PackageName()
    let l:paths = split(@%, '/')
    let l:base = l:paths[0:-2]
    let index = 0

    while index < len(l:base)
        if l:base[index] == 'com'
            break
        endif
        let index = index + 1
    endwhile

    call remove(l:base,0, index-1)
    let l:package = join(l:base, '.')

    call append(0, 'package ' . l:package . ';')

endfunction

" Insert copyright info at BOF
func! Copyright()
    call append(0, '// Copyright (c) ' . strftime("%Y") . ' Dell Boomi, Inc.')
endfunction

" Download and display URL (like read)
func! Get_Url()
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:v_url = @"
    :new "" . l:v_url . ""

    let l:cmd = "curl -L " . l:v_url . " 2>/dev/null"

    "TODO filter out quotes and shit
    call append(0, system(l:cmd) )
    let @" = l:saved_reg

    unlet l:cmd
    unlet l:v_url
    unlet l:saved_reg
endfunction

" Create new unit test from template. (Java)
func! NewUnitTest()
    "TODO probably fails if there are spaces in the path
    let l:filepath = split(@%,"/")
    let l:filename = substitute(l:filepath[-1], '.java', '', '')

    :execute "0read! unit.java.sh " . l:filename
    call PackageName()

    unlet l:filename
    unlet l:filepath
endfunction

" Create new exception from template. (Java)
func! NewException(super)
    "TODO probably fails if there are spaces in the path
    let l:filepath = split(@%,"/")
    let l:filename = substitute(l:filepath[-1], '.java', '', '')

    :execute "0read! exception.java.sh " . l:filename a:super
    call PackageName()

    unlet l:filename
    unlet l:filepath
endfunction

" Compile current maven module. (Java)
func! CompileModule()
    let l:filelist = split(@%, "/")
    let l:module = substitute(l:filelist[0], './', '', '')
    echo "Compiling module: " . l:module . "..."

    :execute "make -pl ". l:module ." compile"

    unlet l:filelist
    unlet l:module
endfunction

function! RightAlignVisual() range
    let l:im = [virtcol("'<"), virtcol("'>")]
    let [l, r] = [min(l:im), max(l:im)]

    :execute "'<,'>" 's/\%'.l.'v.*\%<'.(r+1).'v./\=StrPadLeft(submatch(0),r-l+1)'

    unlet l:im
endfunction

function! StrPadLeft(s, w)
    let s = substitute(a:s, '^\s\+\|\s\+$', '', 'g')
    return repeat(' ', a:w - strwidth(s)) . s
endfunction

" HEX MODE
" ex command for toggling hex mode - define mapping if desired
command! -bar Hexmode call ToggleHex()
nnoremap <C-H> :Hexmode<CR>
inoremap <C-H> <Esc>:Hexmode<CR>
vnoremap <C-H> :<C-U>Hexmode<CR>

" helper function to toggle hex mode
function! ToggleHex()
  " hex mode should be considered a read-only operation
  " save values for modified and read-only for restoration later,
  " and clear the read-only flag for now
  let l:modified=&mod
  let l:oldreadonly=&readonly
  let &readonly=0
  let l:oldmodifiable=&modifiable
  let &modifiable=1
  if !exists("b:editHex") || !b:editHex
    " save old options
    let b:oldft=&ft
    let b:oldbin=&bin
    " set new options
    setlocal binary " make sure it overrides any textwidth, etc.
    let &ft="xxd"
    " set status
    let b:editHex=1
    " switch to hex editor
    %!xxd
  else
    " restore old options
    let &ft=b:oldft
    if !b:oldbin
      setlocal nobinary
    endif
    " set status
    let b:editHex=0
    " return to normal editing
    %!xxd -r
  endif
  " restore values for modified and read only state
  let &mod=l:modified
  let &readonly=l:oldreadonly
  let &modifiable=l:oldmodifiable
endfunction

" autocmds to automatically enter hex mode and handle file writes properly
if has("autocmd")
  " vim -b : edit binary using xxd-format!
  augroup Binary
    au!

    " set binary option for all binary files before reading them
    au BufReadPre *.bin,*.hex setlocal binary

    " if on a fresh read the buffer variable is already set, it's wrong
    au BufReadPost *
          \ if exists('b:editHex') && b:editHex |
          \   let b:editHex = 0 |
          \ endif

    " convert to hex on startup for binary files automatically
    au BufReadPost *
          \ if &binary | Hexmode | endif

    " When the text is freed, the next time the buffer is made active it will
    " re-read the text and thus not match the correct mode, we will need to
    " convert it again if the buffer is again loaded.
    au BufUnload *
          \ if getbufvar(expand("<afile>"), 'editHex') == 1 |
          \   call setbufvar(expand("<afile>"), 'editHex', 0) |
          \ endif

    " before writing a file when editing in hex mode, convert back to non-hex
    au BufWritePre *
          \ if exists("b:editHex") && b:editHex && &binary |
          \  let oldro=&ro | let &ro=0 |
          \  let oldma=&ma | let &ma=1 |
          \  silent exe "%!xxd -r" |
          \  let &ma=oldma | let &ro=oldro |
          \  unlet oldma | unlet oldro |
          \ endif

    " after writing a binary file, if we're in hex mode, restore hex mode
    au BufWritePost *
          \ if exists("b:editHex") && b:editHex && &binary |
          \  let oldro=&ro | let &ro=0 |
          \  let oldma=&ma | let &ma=1 |
          \  silent exe "%!xxd" |
          \  exe "set nomod" |
          \  let &ma=oldma | let &ro=oldro |
          \  unlet oldma | unlet oldro |
          \ endif
  augroup END
endif
"end HEX MODE



if exists('g:loaded_translator') && g:loaded_translator
    finish
endif

if !(exists('g:translate_cmd') || executable('trans'))
    echoerr 'You need to specify a command-line translator first.'
    finish
endif
let g:translate_cmd       = get(g:, 'translate_cmd', 'trans -b -t zh+ja')
let g:translate_player    = get(g:, 'translate_player', 'mplayer')
let g:translate_auto_yank = get(g:, 'translate_auto_yank', 1)

function! translator#speak() range
    let content = substitute(s:get_selection(), '\s', '%20', 'g')
    let uri = '"http://translate.google.com/translate_tts?tl=en&q='.content.'"'
    call system(g:translate_player.' '.uri.' &')
endfunction

function! translator#translate(replace) range
    let content = s:get_selection()
    let command = g:translate_cmd.' "'.content.'"'
    let result = systemlist(command)
    if g:translate_auto_yank
        let @" = join(result, "\n")
    endif
    if a:replace
        return result[0]
    endif
    echohl String
    for line in result
        echomsg line
    endfor
    echohl None
endfunction

function! translator#translate_replace() range
    let @t = translator#translate(1)
    normal! gv"tp
endfunction

function! s:get_selection()
    let [s:lnum1, s:col1] = getpos("'<")[1:2]
    let [s:lnum2, s:col2] = getpos("'>")[1:2]
    let s:lines = getline(s:lnum1, s:lnum2)
    let s:lines[-1] = s:lines[-1][: s:col2 - (&selection == 'inclusive' ? 1 : 2)]
    let s:lines[0] = s:lines[0][s:col1 - 1:]
    return join(s:lines, ' ')
endfunction

vmap <silent> <Plug>Translate        :call translator#translate(0)<CR>
vmap <silent> <Plug>TranslateSpeak   :call translator#speak()<CR>
vmap <silent> <Plug>TranslateReplace :call translator#translate_replace()<CR>

call s:translate_replace()

let g:loaded_translator = 1

## Dependencies

* A translation tool. I suggest [translate-shell](https://github.com/soimort/translate-shell).
* A player for pronunciation. Defaults to mplayer


## Install

If you don't have a preferred method,
I encourage you to use [neobundle.vim](http://github.com/shougo/neobundle.vim).

``` vim
NeoBundleLazy 'farseer90718/vim-translator', {
            \ 'mappings' : '<Plug>Translate'
            \ }
```

## Usage

Create you own mappings like this in your vimrc

``` vim
vmap T <Plug>Translate
vmap R <Plug>TranslateReplace
vmap P <Plug>TranslateSpeak
```

* Assign `g:translate_cmd` to your preferred command for example `ydcv`,
the first target language specified is used in "translate and replace".
* Assign `g:translate_player` to your preferred cli stream player.

## Demo

![gif](./demo.gif)

## License

MIT

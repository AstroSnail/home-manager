" QWERTY usability map

" Actual layout:
" ┌─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬───────────┐
" │ ~   │ !   │ @   │ #   │ $   │ %   │ ^   │ &   │ *   │ (   │ )   │ _   │ +   │           │
" │ `   │ 1   │ 2   │ 3   │ 4   │ 5   │ 6   │ 7   │ 8   │ 9   │ 0   │ -   │ =   │ ⌫         │
" ├─────┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬────────┤
" │ ⇦      │ Q   │ W   │ E   │ R   │ T   │ Y   │ U   │ I   │ O   │ P   │ {   │ }   │        │
" │ ⇥      │ q   │ w   │ e   │ r   │ t   │ y   │ u   │ i   │ o   │ p   │ [   │ ]   │ ↵      │
" ├────────┴─┬───┴─┬───┴─┬───┴─┲━━━┷━┱───┴─┬───┴─┲━━━┷━┱───┴─┬───┴─┬───┴─┬───┴─┬───┴─┐      │
" │          │ A   │ S   │ D   ┃ F   ┃ G   │ H   ┃ J   ┃ K   │ L   │ :   │ "   │ |   │      │
" │ ⎋        │ a   │ s   │ d   ┃ f   ┃ g   │ h   ┃ j   ┃ k   │ l   │ ;   │ '   │ \   │      │
" ├───────┬──┴──┬──┴──┬──┴──┬──┺━━┯━━┹──┬──┴──┬──┺━━┯━━┹──┬──┴──┬──┴──┬──┴──┬──┴─────┴──────┤
" │       │ >   │ Z   │ X   │ C   │ V   │ B   │ N   │ M   │ <   │ >   │ ?   │               │
" │ ⇧     │ <   │ z   │ x   │ c   │ v   │ b   │ n   │ m   │ ,   │ .   │ /   │ ⇧             │
" ├───────┼─────┴──┬──┴─────┼─────┴─────┴─────┴─────┴─────┴─┬───┴────┬┴─────┴─┬─────┬───────┤
" │       │        │        │                               │        │        │     │       │
" │ ⎈     │ ❖      │ ⎇      │ ␣                             │ ⇮      │ ❖      │ ⎄   │ ⎈     │
" └───────┴────────┴────────┴───────────────────────────────┴────────┴────────┴─────┴───────┘

" make scrolling reachable from usual navigation keys
" for some reason <C-S-n/p> don't work?
noremap <C-j> <C-e>
"noremap <C-S-j> <C-S-n>
noremap <C-S-j> <C-d>
noremap <C-k> <C-y>
"noremap <C-S-k> <C-S-p>
noremap <C-S-k> <C-u>

noremap gs <Plug>(easymotion-prefix)

" Notes:
" - noremap works on normal, visual, select, and operator-pending modes simultaneously
" - to enter normal mode, press esc
" - to enter visual mode, press v
" - to enter select mode, press gh
" - to enter operator-pending mode, press an operator command such as d
" TODO:
" - vim-seek

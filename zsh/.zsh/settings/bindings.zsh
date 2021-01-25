#!/bin/zsh

autoload -Uz terminfo up-line-or-beginning-search down-line-or-beginning-search

typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[ShiftTab]="${terminfo[kcbt]}"

[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"      beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"       end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"    overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}" backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"    delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"        up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"      down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"      backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"     forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"    beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"  end-of-buffer-or-history
[[ -n "${key[ShiftTab]}"  ]] && bindkey -- "${key[ShiftTab]}"  reverse-menu-complete

if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    zle-line-init() { echoti smkx; }
    zle-line-finish() { echoti rmkx; }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

# updates editor information when the keymap changes.
zle-keymap-select() { zle reset-prompt; zle -R; }

# ensures the prompt is redrawn when the terminal size changes.
TRAPWINCH() { zle && zle -R; }

zle -N globalias
zle -N fancy-ctrl-z
zle -N zle-keymap-select
zle -N edit-command-line
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# allow ctrl-arrows for forward and backward word
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# allow v to edit the command line (standard behaviour)
autoload -Uz edit-command-line
bindkey -M vicmd 'v' edit-command-line

# allow ctrl-p, ctrl-n for navigate history (standard behaviour)
bindkey '^P' up-history
bindkey '^N' down-history

# allow ctrl-h, ctrl-w, ctrl-? for char and word deletion (standard behaviour)
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word

# allow ctrl-/ to perform backward search in history
bindkey '^_' history-incremental-search-backward

# allow ctrl-a and ctrl-e to move to beginning/end of line
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

# Ctrl-j/k do the same as arrow keys
bindkey "^K" up-line-or-beginning-search
bindkey "^J" down-line-or-beginning-search

# Ctrl-z now toggles
bindkey '^Z' fancy-ctrl-z

# Alt-Enter to enter a linebreak without running the command
bindkey '^[^M' self-insert-unmeta

bindkey -M viins " " globalias
bindkey -M viins "^ " magic-space
bindkey -M isearch " " magic-space

export KEYTIMEOUT=1

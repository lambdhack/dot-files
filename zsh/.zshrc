#!/bin/zsh

# catch non-zsh and non-interactive shells
[[ $- == *i* && $ZSH_VERSION ]] && SHELL=/usr/bin/zsh || return 0

# set some defaults
export HISTFILE=~/.histfile
export MANWIDTH=100
export HISTSIZE=10000
export SAVEHIST=1000000000000000

# path to the framework root directory
SIMPL_ZSH_DIR=~/.zsh

# reduce system calls for timezone
typeset -gx TZ=:/etc/localtime

# add ~/bin to the path if not already, the -U flag means 'unique'
typeset -U path=(~/bin $path[@])

# POWERLEVEL THEME
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme 

# strip empty fields from the path
path=("${path[@]:#}")

# used internally by zsh for loading themes and completions
typeset -U fpath=("$SIMPL_ZSH_DIR/"{completion,themes} $fpath)

# initialize the prompt
autoload -U promptinit && promptinit

# source shell configuration files
for f in "$SIMPL_ZSH_DIR"/{settings,plugins,theme}/*?.zsh; do
    . "$f" 2>/dev/null
done

# uncomment these lines to disable the multi-line prompt
# add user@host, and remove the unicode line-wrap characters

# PROMPT_LNBR1=''
# PROMPT_MULTILINE=''
# PROMPT_USERFMT='%n%f@%F{red}%m'
# PROMPT_ECODE="%(?,,%F{red}%? )"

# load the prompt last
prompt simpl

# system info and AL ascii art
#al-info

export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin/:/usr/local/sbin:$PATH

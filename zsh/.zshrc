# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/zane/.zshrc'

autoload -Uz compinit
compinit


# Faster compinit with caching
zstyle ':completion:*' rehash true
zstyle ':completion:*' menu select
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' use-cache on


# Case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Autocomplete even if you type middle parts
zstyle ':completion:*' matcher-list 'r:|=*' 'l:|=* r:|=*'

# End of lines added by compinstall
bindkey -v
export EDITOR="nvim"
export SUDO_EDITOR="nvim"

# pnpm
export PNPM_HOME="/home/zane/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
eval "$(starship init zsh)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/zane/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/zane/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/home/zane/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/home/zane/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/home/zane/miniforge3/etc/profile.d/mamba.sh" ]; then
    . "/home/zane/miniforge3/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=30

function _zsh_autosuggest_predict_command() {
    local command="$1"
    local last_word="$2"
    
    case "$command" in
        mkdir*)
            echo "cd ${last_word}"
            ;;
    esac
}

export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

# bun completions
[ -s "/home/zane/.bun/_bun" ] && source "/home/zane/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

#gdb
export DEBUGINFOD_URLS="https://debuginfod.archlinux.org"

#tmux
#[ -z "$TMUX"  ] && { tmux attach || exec tmux new-session && exit;}

# Check if TMUX is not already running
if [ -z "$TMUX" ]; then
    # If the terminal is running in VSCode, exit without creating a tmux session
    if [[ "$TERM_PROGRAM" == "vscode" ]]; then
        :
    else
        # Otherwise, attach to an existing tmux session or create a new one
        exec tmux new-session && exit
        exit
    fi
fi

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

update(){
    command yay -Syu --devel --noconfirm --sudoloop
}

activate(){
    source .venv/bin/activate
}

f() {
  local selected_file
  selected_file=$(fd --type f --hidden --exclude .git | fzf)
  [[ -n "$selected_file" ]] && nvim "$selected_file"
}

alias y='yazi'
alias l='nvim'
alias n='nvim'
alias e='exit'
alias q='exit'
alias c='clear'

alias d='cd ..'
alias dd='cd ../..'

# Replace ls with exa
alias la='exa -a --grid'
alias ls='exa --grid'
alias lg='exa -l --grid --git'
alias lag='exa -la --grid --header --git'
alias li='exa -lh --accessed --modified --created'

alias make="make -j`nproc`"
alias ninja="ninja -j`nproc`"


export PATH=/home/zane/.local/bin:$PATH
#zoxide
eval "$(zoxide init zsh)"
alias tmux="tmux -2"

#go
export PATH="$PATH:$(go env GOBIN):$(go env GOPATH)/bin"

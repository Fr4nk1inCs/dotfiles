# History
## History file configuration
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
[ "$HISTSIZE" -lt 50000 ] && HISTSIZE=50000
[ "$SAVEHIST" -lt 10000 ] && SAVEHIST=10000

setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data

# Zim configuration
# Set where the directory used by Zim will be located.
ZIM_HOME=~/.zim

# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
      https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi

# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi

# Initialize modules.
source ${ZIM_HOME}/init.zsh

# Plugin setup
# change keybinds for kitty and termite
bindkey '^[[A' history-substring-search-up
bindkey '^[OA' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[OB' history-substring-search-down

# Environment
# export MOAR='--statusbar=bold --no-linenumbers'
# export PAGER="moar"

# exa alias
alias ls='exa --icons --git'
alias la='exa -a --icons --git'
alias ll='exa -al --icons --git'
alias tree='exa -T --icons --git'

# dust alias
alias du='dust'

# neovim alias
alias vim='nvim'
alias nv='nvim'
alias v='nvim'
alias vc='cd ~/.config/nvim && nvim'
alias qt='cd ~/.config/qtile && nvim'

# neofetch alias
alias n='neofetch'

# image cat
alias icat='kitty +kitten icat'

# ssh
if [[ $TERM = "xterm-kitty" ]]; then
    alias s='kitty +kitten ssh'
    alias ssh='kitty +kitten ssh'
fi
source ~/.ssh/ssh-find-agent.sh
set_ssh_agent_socket

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# autojump
[[ -s /etc/profile.d/autojump.sh ]] && source /etc/profile.d/autojump.sh

# starship
eval "$(starship init zsh)"

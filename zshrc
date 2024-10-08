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

# interactive comment
setopt interactivecomments

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
export MANPAGER="nvim +Man!"
export PAGER="less"

# personal alias
alias :q='exit'

# eza alias
alias ls='eza --icons --git'
alias la='eza -a --icons --git'
alias ll='eza -al --icons --git'
alias tree='eza -T --icons --git'

# dust alias
alias du='dust'

# neovim alias
alias vim='nvim'
alias nv='nvim'
alias v='nvim'
alias vc='cd ~/.config/nvim && nvim'
alias qt='cd ~/.config/qtile && nvim'
alias hy='cd ~/.config/hypr && nvim'

# neofetch alias
alias n='neofetch'

# image cat
alias icat='kitty +kitten icat'

# ssh
if [[ $TERM = "xterm-kitty" ]]; then
    alias s='kitty +kitten ssh'
    alias ssh='kitty +kitten ssh'
fi

# bilibili danmuku
alias bili='bili-live-chat -d 23647637'

# fzf settings
export RUNEWIDTH_EASTASIAN=0
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS"
--color fg:#D8DEE9,bg:#2E3440,hl:#A3BE8C,fg+:#D8DEE9,bg+:#434C5E,hl+:#A3BE8C
--color pointer:#BF616A,info:#4C566A,spinner:#4C566A,header:#4C566A,prompt:#81A1C1,marker:#EBCB8B
--scrollbar="█"
"

zstyle ':fzf-tab:complete:*:*' fzf-preview 'less ${(Q)realpath}'
export LESSOPEN='|~/.lessfilter %s'


zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' fzf-preview 'echo ${(P)word}'

zstyle ':fzf-tab:complete:systemctl-*:*'            fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'

zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview 'git diff $word | delta'
zstyle ':fzf-tab:complete:git-log:*'                fzf-preview 'git log --color=always $word'
zstyle ':fzf-tab:complete:git-help:*'               fzf-preview 'git help $word | bat -plman --color=always'
zstyle ':fzf-tab:complete:git-show:*' fzf-preview \
	'case "$group" in
	"commit tag") git show --color=always $word ;;
	*) git show --color=always $word | delta ;;
	esac'
zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview \
	'case "$group" in
	"modified file") git diff $word | delta ;;
	"recent commit object name") git show --color=always $word | delta ;;
	*) git log --color=always $word ;;
	esac'

# starship
eval "$(starship init zsh)"

# zoxide
eval "$(zoxide init zsh)"

# fzf
eval "$(fzf --zsh)"

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba init' !!
export MAMBA_EXE="/usr/bin/micromamba";
export MAMBA_ROOT_PREFIX="$HOME/micromamba";
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    if [ -f "$HOME/micromamba/etc/profile.d/micromamba.sh" ]; then
        . "$HOME/micromamba/etc/profile.d/micromamba.sh"
    else
        export  PATH="$HOME/micromamba/bin:$PATH"  # extra space after export prevents interference from conda init
    fi
fi
unset __mamba_setup
# <<< mamba initialize <<<

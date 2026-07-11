# Set path if required
#export PATH=$GOPATH/bin:/usr/local/go/bin:$PATH

# Aliases
alias ls='ls --color=auto'
alias ll='ls -lah --color=auto'
alias grep='grep --color=auto'
alias wget="wget --hsts-file=$XDG_DATA_HOME/wget-hsts"
alias docker="podman"
alias docker-compose="podman-compose"

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

setopt histignorealldups sharehistory

# history opts
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE="$XDG_STATE_HOME"/zsh_history
HISTCONTROL=ignoreboth # consecutive duplicates & commands starting with space are not saved

# load modules
zmodload zsh/complist
autoload -U compinit
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"

autoload -U colors && colors

source <(fzf --zsh)

# cmp opts
zstyle ':completion:*' menu select # tab opens cmp menu
# zstyle ':completion:*' special-dirs true # force . and .. to show in cmp menu
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} ma=0\;33 # colorize cmp menu
# zstyle ':completion:*' file-list true # more detailed list
zstyle ':completion:*' squeeze-slashes false # explicit disable to allow /*/ expansion
zstyle ':completion:*' accept-exact false #https://stackoverflow.com/questions/79599764/show-completion-menu-instead-of-auto-selecting-first-match

# main opts
setopt append_history inc_append_history share_history # better history
# on exit, history appends rather than overwrites; history is appended as soon as cmds executed; history shared across sessions
# setopt auto_menu menu_complete # autocmp first menu match
unsetopt menu_complete  # dont auto-select first item
setopt auto_menu    # list first before menu
setopt auto_list    # show completion list when ambiguous

setopt autocd # type a dir to cd
setopt auto_param_slash # when a dir is completed, add a / instead of a trailing space
setopt no_case_glob no_case_match # make cmp case insensitive
setopt globdots # include dotfiles
setopt extended_glob # match ~ # ^
setopt interactive_comments # allow comments in shell
setopt prompt_subst
unsetopt prompt_sp # don't autoclean blanklines
stty stop undef # disable accidental ctrl s

autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats ' (%b)'

PROMPT="%B%{$fg[yellow]%}[%*]%f \
${debian_chroot:+(${debian_chroot})}\
%{$fg[cyan]%}%n%f@%{$fg[green]%}%m%f:%{$fg[blue]%}%~%f\
%{$fg[green]%}\$vcs_info_msg_0_%f%b
>> "

source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export PATH="$PATH:/home/tyler/.local/bin"
eval "$(uv generate-shell-completion zsh)"

# opencode
export PATH=/home/tyler/.opencode/bin:$PATH

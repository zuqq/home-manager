bindkey -v

export VISUAL=vim

# See: https://www.johnhawthorn.com/2012/09/vi-escape-delays/
KEYTIMEOUT=1

bindkey -M viins '^R' history-incremental-search-backward
# See: https://stackoverflow.com/a/549860
stty -ixon && bindkey -M viins '^S' history-incremental-search-forward

HISTFILE=~/.zsh_history
HISTSIZE=2000000
SAVEHIST=1000000

setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY

# See: https://github.com/sindresorhus/pure
fpath+=(~/.zsh/pure)
autoload -U promptinit && promptinit
prompt pure

# See: https://github.com/zsh-users/zsh-autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# See: https://github.com/agkozak/zsh-z
source ~/.zsh/zsh-z/zsh-z.plugin.zsh
autoload -Uz compinit && compinit -i

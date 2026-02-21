#!/bin/zsh

# ================
# Behavior
# ================
  # Use VIM as default editor with vi keybindings
  export EDITOR=vim
  bindkey -v

  # Reduce key timeout for snappier mode switching
  export KEYTIMEOUT=1

  # History
  setopt histignorealldups sharehistory
  HISTSIZE=10000
  SAVEHIST=10000
  HISTFILE=~/.zsh_history

  # Homebrew (macOS)
  if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -f /usr/local/bin/brew ]]; then
    export PATH="/usr/local/sbin:${PATH}"
  fi

  # Completion
  autoload -Uz compinit && compinit -i
  zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'  # Case-insensitive
  zstyle ':completion:*' menu select
  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

  # rbenv (if installed)
  export RBENV_ROOT="${HOME}/.rbenv"
  if [[ -d "${RBENV_ROOT}" ]]; then
    export PATH="${RBENV_ROOT}/bin:${PATH}"
    eval "$(rbenv init - zsh)"
  fi

  # FZF
  export FZF_DEFAULT_COMMAND='(git ls-tree -r --name-only HEAD ||
      find . -path "*/\.*" -prune -o -type f -print -o -type l -print |
      sed s/^..//) 2> /dev/null'
  [[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

# ================
# Prompt
# ================
  autoload -Uz vcs_info
  precmd() { vcs_info }
  setopt prompt_subst

  # Git status with color: green=clean, yellow=staged, red=dirty
  zstyle ':vcs_info:git:*' check-for-changes true
  zstyle ':vcs_info:git:*' stagedstr 'staged'
  zstyle ':vcs_info:git:*' unstagedstr 'dirty'
  zstyle ':vcs_info:git:*' formats '%b %u%c'
  zstyle ':vcs_info:git:*' actionformats '%b (%a) %u%c'

  function _git_prompt_color() {
    local info="${vcs_info_msg_0_}"
    [[ -z "$info" ]] && return

    local branch="${info%% *}"
    local flags="${info#* }"

    if [[ "$flags" == *dirty* ]]; then
      echo "%F{red}${branch}%f"
    elif [[ "$flags" == *staged* ]]; then
      echo "%F{yellow}${branch}%f"
    else
      echo "%F{green}${branch}%f"
    fi
  }

  PROMPT='%F{gray}%1~%f $(_git_prompt_color) %(?.%F{green}.%F{red})❯%f '

# ================
# Aliases
# ================
  alias grep='grep --color=auto'
  alias ls='ls --color=auto'

# ================
# Local overrides
# ================
  [[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

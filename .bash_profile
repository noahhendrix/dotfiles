#!/bin/bash

# ================
# Constants
# ================
    RED="\[\033[0;31m\]"
    YELLOW="\[\033[0;33m\]"
    GREEN="\[\033[0;32m\]"
    LIGHT_GRAY="\[\033[0;37m\]"
    COLOR_NONE="\[\e[0m\]"

# ================
# Behavior
# ================
    export PATH="./bin:~/bin:/usr/local/bin:/usr/local/sbin:$PATH"

    # Use VIM and VIM keybindings in bash
    export EDITOR=vim
    set -o vi

    # Smart tab-completion
    bind 'set completion-ignore-case on'

    # Add autocompletion for other programs like git.
    # Requires `brew install bash-completion`
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
      . $(brew --prefix)/etc/bash_completion
    fi

    # Allow for multiple rubies on the same system.
    # Requires `brew install rbenv`
    export RBENV_ROOT="${HOME}/.rbenv"
    if [ -d "${RBENV_ROOT}" ]; then
      export PATH="${RBENV_ROOT}/bin:${PATH}"
      eval "$(rbenv init -)"
    fi

# ================
# Prompt
# ================
    # Show the git branch name and use color for status (red=dirty, green=clean,
    # yellow=staged) IF you’re in a git repo.
    function set_bash_prompt () {
      # Set the PROMPT_SYMBOL variable. We do this first so we don't lose the
      # return value of the last command.
      if test $? -eq 0 ; then
          prompt_symbol="${GREEN}❯"
      else
          prompt_symbol="${RED}❯"
      fi

      # Capture the output of the `git status` command.
      git_status="$(git status 2> /dev/null)"
      if [[ ${git_status} ]]; then
        # Set color based on clean/staged/dirty.
        if [[ ${git_status} =~ "working directory clean" ]]; then
          color=$GREEN
        elif [[ ${git_status} =~ "Changes to be committed" ]]; then
          color=$YELLOW
        else
          color=$RED
        fi

        # Get the name of the branch.
        branch_pattern="^On branch ([^${IFS}]*)"
        if [[ ${git_status} =~ ${branch_pattern} ]]; then
          branch="${color}${BASH_REMATCH[1]}"
        fi
      else
        branch=""
      fi

      # Set the bash prompt variable.
      PS1="${LIGHT_GRAY}\W ${branch} ${prompt_symbol} ${COLOR_NONE}"
    }

    # Tell bash to execute this function just before displaying its prompt.
    PROMPT_COMMAND=set_bash_prompt

source ~/.bash_work


#!/bin/bash

# ================
# Constants
# ================
    CURRENT_USER=`whoami`

    SCM_CLEAN=0
    SCM_MIXED=1
    SCM_DIRTY=2

    RED="\[\033[0;31m\]"
    YELLOW="\[\033[0;33m\]"
    GREEN="\[\033[0;32m\]"
    BLUE="\[\033[0;34m\]"
    LIGHT_GRAY="\[\033[0;37m\]"
    COLOR_NONE="\[\e[0m\]"

# ================
# Behavior
# ================
    PATH=/usr/local/bin:/usr/local/sbin:$PATH
    export PATH=$PATH

    # RVM
    [[ -s "/Users/${CURRENT_USER}/.rvm/scripts/rvm" ]] && source "/Users/${CURRENT_USER}/.rvm/scripts/rvm"

    export EDITOR=vim
    set -o vi                       # Use VIM keybindings in bash

    # Smart tab-completion
    bind 'set completion-ignore-case on'

    # add autocompletion for other programs like git
    # requires `brew install bash-completion
    if [ -f `brew --prefix`/etc/bash_completion ]; then
      . `brew --prefix`/etc/bash_completion
    fi

# ================
# Shortcuts
# ================
    function is_git_repository {
      git branch > /dev/null 2>&1
    }

    function is_svn_repository {
      svn info > /dev/null 2>&1
    }


    # Determine the branch/state information for this git repository.
    function set_git_branch {
      # Capture the output of the "git status" command.
      git_status="$(git status 2> /dev/null)"

      # Set color based on clean/staged/dirty.
      if [[ ${git_status} =~ "working directory clean" ]]; then
        state=$SCM_CLEAN
      elif [[ ${git_status} =~ "Changes to be committed" ]]; then
        state=$SCM_MIXED
      else
        state=$SCM_DIRTY
      fi

      # Get the name of the branch.
      branch_pattern="^# On branch ([^${IFS}]*)"
      if [[ ${git_status} =~ ${branch_pattern} ]]; then
        branch=${BASH_REMATCH[1]}
      fi

      # Set the final branch string.
      set_scm_branch $state $branch
    }

    function set_svn_branch {
      # Capture the output of the "svn status" command.
      svn_status="$(svn status 2> /dev/null)"

      # Set color based on clean/dirty.
      if [[ -z ${svn_status} ]]; then
        state=$SCM_CLEAN
      else
        state=$SCM_DIRTY
      fi

      revision=`svn info | sed -ne 's/^Revision: //p'`

      set_scm_branch $state $revision
    }

    function set_scm_branch {
      # Set color based on clean/mixed/dirty.
      if [[ $1 -eq $SCM_CLEAN ]]; then
        state="${GREEN}"
      elif [[ $1 -eq $SCM_MIXED ]]; then
        state="${YELLOW}"
      else
        state="${RED}"
      fi

      # Set the final branch string.
      BRANCH="${state}$2${COLOR_NONE}"
    }

    function set_rvm_ruby_version {
      RVM_RUBY_VERSION="${BLUE}$(rvm-prompt g 2> /dev/null)${COLOR_NONE}"
    }

    function set_prompt_symbol () {
      if test $1 -eq 0 ; then
          PROMPT_SYMBOL="${GREEN} ☺ ${COLOR_NONE}"
      else
          PROMPT_SYMBOL="${RED} ☹ ${COLOR_NONE}"
      fi
    }

    function set_bash_prompt () {
      # Set the PROMPT_SYMBOL variable. We do this first so we don't lose the
      # return value of the last command.
      set_prompt_symbol $?

      # Set the BRANCH variable.
      if is_git_repository ; then
        set_git_branch
      elif is_svn_repository ; then
        set_svn_branch
      else
        BRANCH=''
      fi

      set_rvm_ruby_version

      # Set the bash prompt variable.
      PS1="${LIGHT_GRAY}\W ${BRANCH}${RVM_RUBY_VERSION}${PROMPT_SYMBOL}"
    }

    alias ls="ls -Gal"

# Tell bash to execute this function just before displaying its prompt.
PROMPT_COMMAND=set_bash_prompt
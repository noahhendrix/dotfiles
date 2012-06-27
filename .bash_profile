#!/bin/bash

#rvm
  CURRENT_USER=`whoami`
  [[ -s "/Users/${CURRENT_USER}/.rvm/scripts/rvm" ]] && source "/Users/${CURRENT_USER}/.rvm/scripts/rvm"  # This loads RVM into a shell session.

# this makes tab-completion nicer, because it ignores
# case, so `cd co[TAB]` will complete to `cd Code`
bind 'set completion-ignore-case on'

# The various escape codes that we can use to color our prompt.
        RED="\[\033[0;31m\]"
     YELLOW="\[\033[0;33m\]"
      GREEN="\[\033[0;32m\]"
       BLUE="\[\033[0;34m\]"
  LIGHT_RED="\[\033[1;31m\]"
LIGHT_GREEN="\[\033[1;32m\]"
      WHITE="\[\033[1;37m\]"
 LIGHT_GRAY="\[\033[0;37m\]"
 COLOR_NONE="\[\e[0m\]"

# Detect whether the current directory is a git repository.
function is_git_repository {
  git branch > /dev/null 2>&1
}

# Determine the branch/state information for this git repository.
function set_git_branch {
  # Capture the output of the "git status" command.
  git_status="$(git status 2> /dev/null)"

  # Set color based on clean/staged/dirty.
  if [[ ${git_status} =~ "working directory clean" ]]; then
    state="${GREEN}"
  elif [[ ${git_status} =~ "Changes to be committed" ]]; then
    state="${YELLOW}"
  else
    state="${RED}"
  fi
  
  # Get the name of the branch.
  branch_pattern="^# On branch ([^${IFS}]*)"    
  if [[ ${git_status} =~ ${branch_pattern} ]]; then
    branch=${BASH_REMATCH[1]}
  fi

  # Set the final branch string.
  BRANCH="${state}${branch}${COLOR_NONE}"
}

# 
function set_rvm_ruby_version {
  RVM_RUBY_VERSION="${BLUE}$(rvm-prompt g 2> /dev/null)${COLOR_NONE}"
}

# Return the prompt symbol to use, colorized based on the return value of the
# previous command.
function set_prompt_symbol () {
  if test $1 -eq 0 ; then
      PROMPT_SYMBOL="${GREEN} ☺ ${COLOR_NONE}"
  else
      PROMPT_SYMBOL="${RED} ☹ ${COLOR_NONE}"
  fi
}

# Set the full bash prompt.
function set_bash_prompt () {
  # Set the PROMPT_SYMBOL variable. We do this first so we don't lose the 
  # return value of the last command.
  set_prompt_symbol $?

  # Set the BRANCH variable.
  if is_git_repository ; then
    set_git_branch
  else
    BRANCH=''
  fi
  
  set_rvm_ruby_version
  
  # Set the bash prompt variable.
  PS1="${LIGHT_GREEN}\w${LIGHT_GRAY} (${BRANCH}${RVM_RUBY_VERSION}${LIGHT_GRAY})${PROMPT_SYMBOL}"
}

# Tell bash to execute this function just before displaying its prompt.
PROMPT_COMMAND=set_bash_prompt
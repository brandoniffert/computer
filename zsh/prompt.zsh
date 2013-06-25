# Based off of OMZ agnoster theme
# https://github.com/robbyrussell/oh-my-zsh/blob/master/themes/agnoster.zsh-theme

CURRENT_BG='NONE'
SEGMENT_SEPARATOR=''

### Segment drawing
# A few utility functions to make it easy and re-usable to draw segmented prompts

# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n " %{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%} "
  else
    echo -n "%{$bg%}%{$fg%} "
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n $3
}

# End the prompt, closing any open segments
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n " %{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
  CURRENT_BG=''
}

### Prompt components
# Each component will draw itself, and hide itself if no information needs to be shown

# Context: user@hostname (who am I and where am I)
prompt_context() {
  local user=`whoami`

  if [[ "$user" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    prompt_segment black default "%(!.%{%F{yellow}%}.)$user@%m"
  fi
}

# Git: branch/detached head, dirty status, push status
prompt_git() {
  local ref st dirty push
  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    st=$(git status 2>/dev/null | tail -n 1)
    ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git show-ref --head -s --abbrev |head -n1 2> /dev/null)"

    if [[ $st == "nothing to commit, working directory clean" ]]
    then
      prompt_segment green black
    else
      dirty=' ±'
      prompt_segment yellow black
    fi

    [[ $(git cherry -v @{upstream} 2>/dev/null) != "" ]] && push=' ‼'

    echo -n "${ref/refs\/heads\// }$dirty$push"
  fi
}

# Dir: current working directory
prompt_dir() {
  if [[ $PROFILE_BG == 'light' ]]
  then
    prompt_segment white black '%~'
  else
    prompt_segment blue white '%~'
  fi
}

# Status:
# - was there an error
# - am I root
# - are there background jobs?
prompt_status() {
  local symbols
  symbols=()
  [[ $RETVAL -ne 0 ]] && symbols+="%{%F{red}%}✘"
  [[ $UID -eq 0 ]] && symbols+="%{%F{yellow}%}⚡"
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{green}%}⚙"

  [[ -n "$symbols" ]] && prompt_segment black default "$symbols"
}

## Main prompt
build_prompt() {
  RETVAL=$?
  prompt_status
  prompt_context
  prompt_dir
  prompt_git
  prompt_end
}

PROMPT='%{%f%b%k%}$(build_prompt) '

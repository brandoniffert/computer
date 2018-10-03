# Serve a directory on localhost and open in browser
function server() {
  local port="${1:-9876}"
  open "http://localhost:${port}/"
  python -m SimpleHTTPServer $port
}

# Serve a directory on localhost and open in browser (php)
function pserver() {
  local port="${1:-6789}"
  open "http://localhost:${port}/"
  php -S localhost:$port
}

# Extract archives - use: xtract <file>
# Credits to http://dotfiles.org/~pseup/.bashrc
function xtract() {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2) tar xjf $1 ;;
      *.tar.gz) tar xzf $1 ;;
      *.bz2) bunzip2 $1 ;;
      *.rar) rar x $1 ;;
      *.gz) gunzip $1 ;;
      *.tar) tar xf $1 ;;
      *.tbz2) tar xjf $1 ;;
      *.tgz) tar xzf $1 ;;
      *.zip) unzip $1 ;;
      *.Z) uncompress $1 ;;
      *.7z) 7z x $1 ;;
      *) echo "'$1' cannot be extracted via xtract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Get gzipped size
function gz() {
  echo "orig size    (bytes): "
  cat "$1" | wc -c
  echo "gzipped size (bytes): "
  gzip -c "$1" | wc -c
}

# Get all dig info
function digg() {
  dig +nocmd "$1" any +multiline +noall +answer
}

# Determine size of a file or total size of a directory
function fs() {
  if du -b /dev/null > /dev/null 2>&1; then
    local arg=-sbh
  else
    local arg=-sh
  fi
  if [[ -n "$@" ]]; then
    du $arg -- "$@"
  else
    du $arg .[^.]* *
  fi
}

# Colorize man pages
function man() {
  LESS_TERMCAP_md=$'\e[01;34m' \
  LESS_TERMCAP_me=$'\e[0m' \
  LESS_TERMCAP_se=$'\e[0m' \
  LESS_TERMCAP_so=$'\e[01;44;30m' \
  LESS_TERMCAP_ue=$'\e[0m' \
  LESS_TERMCAP_us=$'\e[01;32m' \
  command man "$@"
}

# Shows the most used shell commands.
function histstat() {
  history 0 | awk '{print $2}' | sort | uniq -c | sort -n -r | head
}

# Use fzf to quickly get to a project
function p() {
  local ignore='Projects$|sites$'
  cd "$(
    find ~/Projects/Work ~/Projects/Life ~/Projects/vagrant-lemp/sites ~/Projects/vagrant-lemp/sites-available -maxdepth 1 -type d |
    grep -Ev $ignore |
    fzf
  )"
}

function pw() {
  local ignore='Projects\/Work$|sites$'
  cd "$(
    find ~/Projects/Work ~/Projects/vagrant-lemp/sites ~/Projects/vagrant-lemp/sites-available -maxdepth 1 -type d |
    grep -Ev $ignore |
    fzf
  )"
}

function pl() {
  local ignore='Projects\/Life$'
  cd "$(
    find ~/Projects/Life -maxdepth 1 -type d |
    grep -Ev $ignore |
    fzf
  )"
}

# Use fzf to quickly get to a note
function n() {
  $EDITOR "$(find $HOME/Dropbox/Notes -maxdepth 1 -type f | fzf)"
}

# Quickly open life journal
function jlife() {
  $EDITOR -c 'silent Goyo | set ft=markdown.journal' ~/Dropbox/Notes/Life.md
}

# Quickly open work journal
function jwork() {
  $EDITOR -c 'silent Goyo | set ft=markdown.journal' ~/Dropbox/Notes/Work.md
}

# Quickly open both life and work journals
function jlogs() {
  $EDITOR -c 'silent Goyo 160 | vsp ~/Dropbox/Notes/Life.md | bufdo setlocal ft=markdown.journal | wincmd h' ~/Dropbox/Notes/Work.md
}

# Use fzf to upgrade installed homebrew package
function brewup {
  brew upgrade $(brew list | fzf)
}

# Browse Chrome history
function bhist() {
  local cols sep google_history open
  cols=$(( COLUMNS / 3 ))
  sep='{::}'

  if [ "$(uname)" = "Darwin" ]; then
    google_history="$HOME/Library/Application Support/Google/Chrome/Default/History"
    open=open
  else
    google_history="$HOME/.config/google-chrome/Default/History"
    open=xdg-open
  fi
  cp -f "$google_history" /tmp/h
  sqlite3 -separator $sep /tmp/h \
    "select substr(title, 1, $cols), url
     from urls order by last_visit_time desc" |
  awk -F $sep '{printf "%-'$cols's  \x1b[36m%s\x1b[m\n", $1, $2}' |
  fzf --ansi --multi | sed 's#.*\(https*://\)#\1#' | xargs $open > /dev/null 2> /dev/null
}

# Quickly manage homestead vagrant from anywhere
function hs() {
  if [ $# -eq 0 ]; then
    cd "$HOME/Projects/vagrant-homestead"
  else
    ( cd "$HOME/Projects/vagrant-homestead" && vagrant $* && write-vagrant-global-status )
  fi
}

# ts [FUZZY PATTERN] - Select selected tmux session
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
function ts() {
  local session
  session=$(tmux list-sessions -F "#{session_name}" | \
    fzf --query="$1" --select-1 --exit-0) &&
  tmux switch-client -t "$session"
}

# Allow Ctrl-z to toggle between suspend and resume
function Resume {
    fg
    zle push-input
    BUFFER=""
    zle accept-line
}
zle -N Resume
bindkey "^Z" Resume

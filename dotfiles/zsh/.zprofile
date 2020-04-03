# Language
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_COLLATE=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_MESSAGES=en_US.UTF-8
export LC_MONETARY=en_US.UTF-8
export LC_NUMERIC=en_US.UTF-8
export LC_TIME=en_US.UTF-8
export LESSCHARSET=utf-8

# Manually manage XDG for some programs
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME"/aws/config
export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME"/aws/credentials
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export COMPOSER_HOME="$XDG_DATA_HOME"/composer
export GEM_HOME="$XDG_DATA_HOME"/gem
export GEM_SPEC_CACHE="$XDG_CACHE_HOME"/gem
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node/repl_history
export N_PREFIX="$XDG_DATA_HOME/n"
export npm_config_cache="$XDG_CACHE_HOME"/npm
export npm_config_devdir="$XDG_CACHE_HOME"/node-gyp
export npm_config_userconfig="$XDG_CONFIG_HOME"/npm/config
export PYENV_ROOT="$XDG_DATA_HOME"/pyenv
export RBENV_ROOT="$XDG_DATA_HOME"/rbenv
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME"/ripgrep/ripgreprc
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export SQLITE_HISTORY="$XDG_DATA_HOME"/sqlite_history
export SUBVERSION_HOME="$XDG_CONFIG_HOME"/subversion
export VAGRANT_HOME="$XDG_DATA_HOME"/vagrant
export VAGRANT_ALIAS_FILE="$XDG_DATA_HOME"/vagrant/aliases
export _Z_DATA="$XDG_DATA_HOME"/z

# PATH
path=(
  "$ZDOTDIR"/bin
  "$HOME"/.local/bin
  "$N_PREFIX"/bin
  "$XDG_DATA_HOME"/composer/vendor/bin
  /usr/local/sbin
  $path
)

# Ensure path arrays do not contain duplicates
typeset -gU cdpath fpath path

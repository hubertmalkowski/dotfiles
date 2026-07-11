if status is-interactive
    # Commands to run in interactive sessions can go here
end
set -U fish_greeting

# pnpm
set -gx PNPM_HOME "/home/hubert/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end

# pnpm end
#open_tmux

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# Added by Radicle.
export PATH="$PATH:/home/hubert/.radicle/bin"

export GOBIN="/home/hubert/gobin"
export PATH="$PATH:$GOPATH"

set -gx WASMTIME_HOME "$HOME/.wasmtime"

string match -r ".wasmtime" "$PATH" > /dev/null; or set -gx PATH "$WASMTIME_HOME/bin" $PATH

# Wasmer
export WASMER_DIR="/home/hubert/.wasmer"
[ -s "$WASMER_DIR/wasmer.sh" ] && source "$WASMER_DIR/wasmer.sh"

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /home/hubert/.ghcup/bin $PATH # ghcup-env

# opencode
fish_add_path /home/hubert/.opencode/bin

# ZVM
set -gx ZVM_INSTALL "$HOME/.zvm/self"
set -gx PATH $PATH "$HOME/.zvm/bin"
set -gx PATH $PATH "$ZVM_INSTALL/"

# ASDF configuration code
if test -z $ASDF_DATA_DIR
    set _asdf_shims "$HOME/.asdf/shims"
else
    set _asdf_shims "$ASDF_DATA_DIR/shims"
end

# Do not use fish_add_path (added in Fish 3.2) because it
# potentially changes the order of items in PATH
if not contains $_asdf_shims $PATH
    set -gx --prepend PATH $_asdf_shims
end
set --erase _asdf_shims

set -gx PYENV_ROOT $HOME/.pyenv
if test -d $PYENV_ROOT/bin
    fish_add_path $PYENV_ROOT/bin
end
status is-interactive; and pyenv init - fish | source
status is-interactive; and pyenv virtualenv-init - | source

set -gx ZK_NOTEBOOK_DIR "$HOME/Okieneczko"

eval (opam env)

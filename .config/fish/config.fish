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

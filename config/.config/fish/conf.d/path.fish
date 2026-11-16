# MANPATH
set -gx --prepend MANPATH /opt/homebrew/share/man ''

# PATH setup
# fish_add_path is idempotent — safe to call every shell startup.
# It prepends by default; use --append for lower-priority paths.

# Homebrew & system (prepend = high priority)
fish_add_path /usr/local/bin
fish_add_path /opt/homebrew/sbin
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/opt/libpq/bin
fish_add_path /opt/homebrew/Cellar/avr-gcc@8/8.5.0/bin

# Language toolchains & local bins (append = lower priority)
fish_add_path --append /usr/local/bin/php
fish_add_path --append /usr/local/go/bin
fish_add_path --append $HOME/.composer/vendor/bin
fish_add_path --append $HOME/go/bin
fish_add_path --append $HOME/.bun/bin
fish_add_path --append $HOME/.cargo/bin
fish_add_path --append $HOME/.local/bin
fish_add_path --append $HOME/.juliaup/bin

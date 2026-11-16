# Zoxide — smarter cd
# --cmd cd replaces the built-in `cd` with zoxide's `z`, and adds `cdi` for interactive
# This matches your nushell config: alias cd = z, alias cdi = zi
zoxide init fish --cmd cd | source

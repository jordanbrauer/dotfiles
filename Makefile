.DEFAULT_GOAL := help
.PHONY: help sync sync-check install

STOW_FLAGS ?= --no-folding

help: ## Show this help message
	@printf "\033[33mUsage:\033[0m\n  make [target] [arg=\"val\"...]\n\n\033[33mTargets:\033[0m\n"
	@grep -E '^[-a-zA-Z0-9_\.\/]+:.*?## .*$$' $(firstword $(MAKEFILE_LIST)) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[32m%-15s\033[0m %s\n", $$1, $$2}'

sync: ## Sync all symlinks for the configurations
	@stow $(STOW_FLAGS) --target="$$HOME" vim config todo git nb misc
	@stow $(STOW_FLAGS) --dir=./config/.config/ --target="$$HOME/Library/Application Support/nushell" nushell

sync-check: ## Preview symlink changes without modifying files
	@$(MAKE) --no-print-directory sync STOW_FLAGS="--no-folding --simulate --verbose"

install: ## Attempt to install dependencies. Typically only used for new computers
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# mkdir ~/.vim/{plugged,undodir}
	@brew update
	@brew install node php go python fnm jq xsv bat fzf bottom glow ripgrep fd stow \
		code-minimap fish nushell vivid starship hurl vhs gum helix lazygit \
		lazydocker zk jrnl todo-txt yazi gh biome lua luarocks lua-language-server \
		zoxide tree hledger git-delta television direnv marksman nb slides \
		pgcli yq just beads felixkratz/formulae/sketchybar \
		felixkratz/formulae/borders webstonehq/tap/tuxedo
	@brew install --cask nikitabobko/tap/aerospace kitty 1password-cli font-sf-pro
	@npm install -g intelephense typescript typescript-language-server ts-node vscode-langservers-extracted
	@bat cache --build

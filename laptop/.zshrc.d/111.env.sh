alias l="ls -la"
alias vib="vim -u NONE"

export EDITOR="vim -u NONE"

export GOPATH=$CLARIFAI_ROOT/go
export GO15VENDOREXPERIMENT=1

# disable telemetry
export SAM_CLI_TELEMETRY=0
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export HOMEBREW_NO_ANALYTICS=1

export PATH="$PATH:$HOME/.local/bin:$GOPATH/bin"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

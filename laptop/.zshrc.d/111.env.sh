alias l="ls -la"
alias vib="vim -u NONE"

export EDITOR="vim -u NONE"

if [[ -d "$HOME/go" ]]; then
    export GOPATH="$HOME/go"
    export PATH="$PATH:$GOPATH/bin"
fi

# disable telemetry
export SAM_CLI_TELEMETRY=0
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export HOMEBREW_NO_ANALYTICS=1

export PATH="$PATH:~/.local/bin"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

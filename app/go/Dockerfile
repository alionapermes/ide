FROM golang:alpine

RUN apk add bash nodejs npm yarn neovim curl git ripgrep fzf font-jetbrains-mono-nerd build-base --update
RUN LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)

ENV PATH="$PATH:/root/.local/bin"

RUN go install golang.org/x/tools/gopls@latest
RUN go install github.com/nametake/golangci-lint-langserver@latest
RUN go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest

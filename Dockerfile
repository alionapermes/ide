FROM alpine:latest

# ARG WORKDIR=.

# NvChad setup
RUN apk add git nodejs neovim font-jetbrains-mono-nerd ripgrep build-base wget --update
RUN git clone https://github.com/NvChad/NvChad ~/.config/nvim

# nedi setup
RUN mkdir ~/.config/nvim/lua/custom
COPY ./lua/* ~/.config/nvim/lua/custom/

# RUN apk add nodejs npm yarn

RUN apk add go
RUN go install golang.org/x/tools/gopls@latest
RUN go install github.com/nametake/golangci-lint-langserver@latest
RUN go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest

# RUN npm i -g bash-language-server

ENTRYPOINT exec nvim

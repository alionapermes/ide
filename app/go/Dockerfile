FROM golang:alpine

RUN apk add bash

# NvChad setup
RUN apk add git nodejs neovim font-jetbrains-mono-nerd ripgrep build-base wget --update
RUN git clone https://github.com/NvChad/NvChad ~/.config/nvim

RUN mkdir /root/.config/nvim/lua/custom
COPY ./lua /root/.config/nvim/lua/custom

RUN mkdir -p /root/.local/share/nvim/nvchad
RUN mkdir -p /root/.local/share/nvim/lazy

RUN mkdir -p /root/workspace

# go
# RUN apk add go
RUN go install golang.org/x/tools/gopls@latest
RUN go install github.com/nametake/golangci-lint-langserver@latest
RUN go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
RUN go install golang.org/x/tools/cmd/goimports@latest
RUN go install github.com/segmentio/golines@latest
# RUN go install github.com/bufbuild/buf-language-server/cmd/bufls@latest

RUN apk add npm yarn

# yaml
RUN yarn global add yaml-language-server

# docker-compose
RUN npm i -g @microsoft/compose-language-service

# jsonls, eslint
RUN npm i -g vscode-langservers-extracted

# bash
RUN npm i -g bash-language-server

# volar
RUN npm i -g @vue/language-server

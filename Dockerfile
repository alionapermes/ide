FROM alpine:latest

# NvChad setup
RUN apk add git nodejs neovim font-jetbrains-mono-nerd ripgrep build-base wget --update
RUN git clone https://github.com/NvChad/NvChad ~/.config/nvim

RUN mkdir /root/.config/nvim/lua/custom
COPY ./lua /root/.config/nvim/lua/custom

RUN mkdir -p /root/.local/share/nvim/nvchad
RUN mkdir -p /root/.local/share/nvim/lazy

RUN mkdir -p /root/workspace

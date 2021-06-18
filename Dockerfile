FROM parrotsec/security

RUN \
    apt update && \
    apt full-upgrade -y && \
    apt install -y \
        firefox \
        python3-dev \
        python3-venv \
        python3-virtualenv \
        python3-pip && \
    # pip pkgs
    python3 -m pip install -U \
        hashcrack-jtr \
        impacket \
        siranga && \
    # create new user
    useradd -m -G audio,video -s /usr/bin/zsh dev && \
    echo "dev ALL=(ALL) NOPASSWD: ALL" | tee -a /etc/sudoers
 
USER dev
WORKDIR /home/dev

ENV LC_ALL=en_US.UTF-8
ENV LC_CTYPE=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8

# Setup user specifics
RUN \
    cd /home/dev && \
    curl -SL -o .zshrc https://raw.githubusercontent.com/Wh1t3Fox/dotfiles/master/.zshrc && \
    curl -SL -o .vimrc https://raw.githubusercontent.com/Wh1t3Fox/dotfiles/master/.vimrc && \
    curl -SL -o .tmux.conf https://raw.githubusercontent.com/Wh1t3Fox/dotfiles/master/.tmux.conf

VOLUME ["/data"]

CMD ["/usr/bin/zsh"]

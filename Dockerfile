FROM archlinux

RUN pacman -Syy reflector pacman-contrib --noconfirm && \
    reflector -l 200 -f 10 --sort rate -c 'United States' --save /etc/pacman.d/mirrorlist && \
    paccache --remove --keep 0 && \
    # multiarch
    echo -e "[multilib]\nInclude = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf && \
    # allow manpages
    sed -i '/NoExtract  = usr\/share\/man\//d' /etc/pacman.conf && \
    # update locale
    echo 'LANG=en_US.UTF-8' > /etc/locale.conf && \
    locale-gen en_US.UTF-8 && \
    # install pkgs
    pacman -Syyu --noconfirm && \
    pacman -S \
        afl \
        afl-utils \
        base-devel \
        binwalk \
        curl \
        fzf \
        git \
        iproute2 \
        man \
        man-pages \
        netcat \
        patchelf \
        p7zip \
        python \
        python-pip \
        radare2 \
        r2ghidra-dec \
        screen \
        sudo \
        thefuck \
        tmux \
        unrar \
        unzip \
        vim \
        wget \
        xorg-server \ 
        xorg-server-common \ 
        zip \
        zsh \
        zsh-autosuggestions \
        zsh-completions \
        zsh-history-substring-search \
        zsh-syntax-highlighting \
    --noconfirm && \
    paccache --remove --keep 0 && \
    # pip pkgs
    python -m pip install -U \
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
RUN cd /tmp && \
    # Install yay
    git clone https://aur.archlinux.org/yay.git && \
    cd yay && makepkg -sri --noconfirm && \
    cd - && rm -fr /tmp/yay && \
    paccache --remove --keep 0 && \
    # antigen
    mkdir -p /home/dev/.config/ && \
    curl -SL -o /home/dev/.config/antigen.zsh https://git.io/antigen && \
    # zshrc
    curl -SL -o /home/dev/.zshrc https://raw.githubusercontent.com/Wh1t3Fox/dotfiles/master/.zshrc

VOLUME ["/data"]

CMD ["/usr/bin/zsh"]

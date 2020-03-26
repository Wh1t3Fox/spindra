FROM kalilinux/kali

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get -y upgrade && \
    apt-get install -y \
        kali-linux-default \
        build-essential \
        git \
        python3-dev \
        python3-pip \
        net-tools \
        locales \
        locales-all && \
    rm -fr /var/lib/apt/lists/* && \
    pip3 install siranga

# Install New User
RUN echo "_JAVA_AWT_WM_NONREPARENTING=1" >> /etc/profile.d/jre.sh && \
 locale-gen en_US.UTF-8 && \
 echo 'LANG=en_US.UTF-8' > /etc/locale.conf && \
 useradd -m -G audio,video -s /bin/bash dev && \
 echo "dev ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/dev && \
 chmod 0440 /etc/sudoers.d/dev

COPY ./entrypoint /
ENTRYPOINT ["/bin/bash", "/entrypoint"]

USER dev
WORKDIR /home/dev

ENV LC_ALL=en_US.UTF-8
ENV LC_CTYPE=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8

RUN mkdir git && \
    git clone https://github.com/SecureAuthCorp/impacket.git git/impacket && \
    sudo pip3 install git/impacket/

VOLUME ["/data"]

CMD ["/bin/bash"]

FROM kalilinux/kali-linux-docker

RUN apt-get update && apt-get -y upgrade && \
    apt-get install -y \
    kali-linux-default \
    fonts-noto \
    fonts-noto-cjk \
    fonts-noto-color-emoji \
    libexif-dev \
    libgl1-mesa-dri \
    libgl1-mesa-glx \
    libpango1.0-0 \
    libpulse0 \
    libasound2 \
    libasound2-plugins \
    libcanberra-gtk* \
    libpulse0 \
    pulseaudio \
    locales \
    locales-all && \
    rm -fr /var/lib/apt/lists/*

# Install New User
RUN echo "_JAVA_AWT_WM_NONREPARENTING=1" >> /etc/profile.d/jre.sh && \
 locale-gen en_US.UTF-8 && \
 echo 'LANG=en_US.UTF-8' > /etc/locale.conf && \
 useradd -m -G audio,video -s /bin/bash dev && \
 echo "dev ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/dev && \
 chmod 0440 /etc/sudoers.d/dev

USER dev
WORKDIR /home/dev

ENV LC_ALL=en_US.UTF-8
ENV LC_CTYPE=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8

CMD ["/bin/bash"]

FROM kalilinux/kali-linux-docker:latest

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -yqq update && \
	apt-get install -yqq \
        kali-linux \
        kali-linux-top10 \
        kali-linux-web \
        kali-linux-forensic \
        kali-linux-pwtools && \
    pip install -U pip && \
    pip install capstone pwntools ropgadget angr && \
	apt-get -yqq upgrade && \
    apt-get -yqq dist-upgrade && \
    apt-get clean && \
    export uid=1000 gid=1000 && \
    mkdir -p /home/dev && \
    echo "dev:x:${uid}:${gid}:Developer,,,:/home/dev:/bin/bash" >> /etc/passwd && \
    echo "dev:x:${uid}:" >> /etc/group && \
    echo "dev ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/dev && \
    chmod 0440 /etc/sudoers.d/dev && \
    chown ${uid}:${gid} -R /home/dev

WORKDIR /home/dev
USER dev
 
CMD ["bash"]

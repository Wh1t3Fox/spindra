FROM kalilinux/kali-linux-docker:latest

ENV DEBIAN_FRONTEND noninteractive
# Install Base PKGS
RUN apt-get -yqq update && \
	apt-get install -yqq \
        kali-linux \
        kali-linux-top10 \
        kali-linux-web \
        kali-linux-forensic \
        kali-linux-pwtools \
        python3-dev \
        python3-pip && \
    pip install capstone pwntools ropgadget angr && \
    pip3 install capstone pwntools ropgadget && \
	apt-get -yqq upgrade && \
    apt-get -yqq dist-upgrade && \
    apt-get clean && \
    # Add New User
    export uid=1000 gid=1000 && \
    mkdir -p /home/dev && \
    echo "dev:x:${uid}:${gid}:Developer,,,:/home/dev:/bin/bash" >> /etc/passwd && \
    echo "dev:x:${uid}:" >> /etc/group && \
    echo "dev ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/dev && \
    chmod 0440 /etc/sudoers.d/dev && \
    chown ${uid}:${gid} -R /home/dev && \
    # Custom PKGS
    git clone https://github.com/tentpegbob/ropgadget.git /opt/ropgadget && \
    echo "source /opt/ropgadget/ROPgadget.py" >> /etc/gdb/gdbinit

WORKDIR /home/dev
USER dev
 
CMD ["bash"]

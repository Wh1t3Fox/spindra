FROM archlinux/base:latest

# Install ArchStrike
RUN pacman -Syyu --noconfirm && \
	pacman -S base-devel wget --noconfirm && \
	sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf && \
	echo -e "[archstrike]\nServer = https://mirror.archstrike.org/\$arch/\$repo" >> /etc/pacman.conf && \
	pacman -Syy && \
	pacman-key --init && \
	dirmngr < /dev/null && \
	wget https://archstrike.org/keyfile.asc && \
	wget https://archstrike.org/keyfile-checksum && \
	sha512sum -c keyfile-checksum && \
	pacman-key --add keyfile.asc && \
	pacman-key --lsign-key 9D5F1C051D146843CDA4858BDE64825E7CBC0D51 && \
	pacman -S archstrike-keyring --noconfirm && \
	pacman -S archstrike-mirrorlist --noconfirm && \
	sed -i 's|Server = https://mirror.archstrike.org/$arch/$repo|Include = /etc/pacman.d/archstrike-mirrorlist|' /etc/pacman.conf && \
	pacman -Syyu --noconfirm

# Install New User
RUN echo "_JAVA_AWT_WM_NONREPARENTING=1" >> /etc/profile.d/jre.sh && \
    export uid=1000 gid=1000 && \
    mkdir -p /home/dev && \
    echo "dev:x:${uid}:${gid}:Developer,,,:/home/dev:/bin/bash" >> /etc/passwd && \
    echo "dev:x:${uid}:" >> /etc/group && \
    echo "dev ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/dev && \
    chmod 0440 /etc/sudoers.d/dev && \
    chown ${uid}:${gid} -R /home/dev

# Archstrike Groups
RUN pacman -S --noconfirm \
        archstrike-mitm \
        archstrike-reverse \
        archstrike-stego \
        archstrike-tunnel \
        archstrike-wordlists 

# Additional Stuffss
RUN pacman -Syyu --noconfirm && \
    pacman -S --noconfirm \
        firefox tmux vim git \
        python-pip \
        burpsuite sqlmap wpscan nikto \
        radamsa gdb binwalk pwntools angr \
        stegsolve nmap unzip bettercap \
        mimikatz mimikittenz-git beef-git \
        powersploit-git set-git windows-exploit-suggester-git && \
    pip install capstone pwntools ropgadget && \
    git clone https://github.com/tentpegbob/ropgadget.git /opt/ropgadget && \
    echo "source /opt/ropgadget/ROPgadget.py" >> /etc/gdb/gdbinit

WORKDIR /home/dev
USER dev

CMD ["bash"]

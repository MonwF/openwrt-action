FROM arm64v8/debian:buster

ENV TZ=Asia/Shanghai

RUN apt-get update -qq && \
    apt-get install -qqy \
        sudo openssh-server time git-core subversion build-essential g++ bash make \
        libssl-dev patch libncurses5 libncurses5-dev zlib1g-dev gawk \
        flex gettext wget unzip xz-utils python python-distutils-extra \
        python3 python3-distutils-extra rsync curl libsnmp-dev liblzma-dev \
        libpam0g-dev cpio rsync vim && \
    apt-get clean

RUN mkdir /var/run/sshd && \
    useradd -m -G sudo -s /bin/bash openwrt && \
    echo 'openwrt:openwrt' | chpasswd && \
    echo 'openwrt ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/openwrt && \
    sed -i "s/#PasswordAuthentication/PasswordAuthentication/" /etc/ssh/sshd_config

USER openwrt
WORKDIR /home/openwrt

EXPOSE 22

CMD ["/usr/bin/sudo", "/usr/sbin/sshd", "-D"]

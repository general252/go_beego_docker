FROM centos:7

MAINTAINER MNicholas "go_web@163.com"

# ADD nginx-1.12.2.tar.gz /usr/local/src

RUN set -eux; \
    cd /home; \
    echo root:"123456" | chpasswd; \
    yum install -y openssh-server; \
    ssh-keygen -q -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key -N ''; \
    ssh-keygen -q -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N ''; \
    ssh-keygen -t dsa -f /etc/ssh/ssh_host_ed25519_key -N ''; \
    yum install -y wget; \
    yum install -y gcc; \
    yum -y install gcc-c++; \
    yum install -y git; \
    wget --no-check-certificate https://dl.google.com/go/go1.12.5.linux-amd64.tar.gz; \
    tar -C /usr/local -xzf go1.12.5.linux-amd64.tar.gz; \
    yum clean all; \
    rm -rf /var/cache/yum;

RUN cd /home; \
    export PATH="/usr/local/go/bin:$PATH"; \
    go version; \
    go get github.com/astaxie/beego; \
    go get github.com/beego/bee;

#RUN    cd /home/ \
#    && bee new quickstart \
#    && cd $GOPATH/quickstart/ \
#    && bee run

WORKDIR /home/

EXPOSE 22 8080 8000 8001 8002 8003 8004 8005

CMD ["/usr/sbin/sshd", "-D"]

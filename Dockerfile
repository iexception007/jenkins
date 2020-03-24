FROM jenkins/jenkins:centos
USER root

RUN yum install -y make && \
    yum install -y bzip2 && \
    yum install -y wget && \
    yum install -y jq && \
    #yum install -y git2u && \
    yum install -y python36 && \
    yum install -y python3-pip && \
    #pip install --upgrade pip && \
    pip3 install yq && \
    wget -O /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v1.16.0/bin/linux/amd64/kubectl && \
    chmod +x /usr/local/bin/kubectl && \
    mkdir -p /root/.kube && \
    wget -O docker.tgz https://download.docker.com/linux/static/stable/x86_64/docker-19.03.1.tgz && \
    gunzip -c docker.tgz | tar xvf - && \
    mv docker/docker /usr/local/bin/docker && \
    chmod +x /usr/local/bin/docker && \
    rm -rf ./docker ./docker.tgz && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    yum clean all

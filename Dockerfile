# vim: filetype=dockerfile

# FROM ubuntu:22.04
FROM nvidia/cuda:12.3.2-cudnn9-runtime-ubuntu22.04

# RUN sed -i -e 's/archive.ubuntu.com/mirrors.ustc.edu.cn/' -e 's/security.ubuntu.com/mirrors.ustc.edu.cn/' /etc/apt/sources.list

# COPY deepmd-kit-3.0.0a0-cuda123-Linux-x86_64.sh /tmp/deepmd-kit-3.0.0a0-cuda123-Linux-x86_64.sh
RUN wget https://github.com/deepmodeling/deepmd-kit/releases/download/v3.0.0a0/deepmd-kit-3.0.0a0-cuda123-Linux-x86_64.sh.0 && \
    wget https://github.com/deepmodeling/deepmd-kit/releases/download/v3.0.0a0/deepmd-kit-3.0.0a0-cuda123-Linux-x86_64.sh.1 && \
    cat deepmd-kit-3.0.0a0-cuda123-Linux-x86_64.sh.0 deepmd-kit-3.0.0a0-cuda123-Linux-x86_64.sh.1 > /tmp/deepmd-kit-3.0.0a0-cuda123-Linux-x86_64.sh && \
    rm -f deepmd-kit-3.0.0a0-cuda123-Linux-x86_64.sh.0 deepmd-kit-3.0.0a0-cuda123-Linux-x86_64.sh.1

ENV PATH=/opt/conda/bin:$PATH

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      ssh \
      curl \
      wget \
      openssl \
      ca-certificates \
      && \
    apt-get autoremove --purge -y && \
    apt-get autoclean -y && \
    rm -rf /var/cache/apt/* /var/lib/apt/lists/* && \
    bash /tmp/deepmd-kit-3.0.0a0-cuda123-Linux-x86_64.sh -b -p /opt/conda && \
    /opt/conda/bin/conda init && \
    /opt/conda/bin/pip install --index-url=https://mirrors.bfsu.edu.cn/pypi/web/simple --no-cache-dir "tf-keras==2.15.0"

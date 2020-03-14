FROM nginx

MAINTAINER "tuke tukeof@gmail.com"

EXPOSE 80

RUN echo "deb http://mirrors.ustc.edu.cn/debian stable main contrib non-free" >> /etc/apt/sources.list && \
    echo "deb http://mirrors.ustc.edu.cn/debian stable-updates main contrib non-free" >> /etc/apt/sources.list && \
    apt-get update -y && apt-get install curl -y && \
    apt-get autoremove -y && apt-get autoclean -y && apt-get clean -y && apt-get purge -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*



FROM tukeof/oraclejre

MAINTAINER "tuke tukeof@gmail.com"

RUN apt-get update -y && apt-get install -y ssh && \
    mkdir /run/sshd && \
    ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

# hadoop
ENV HADOOP_VERSION=3.2.0
ENV HADOOP_HOME=/usr/local/hadoop-${HADOOP_VERSION}
ENV HADOOP_CONF_DIR=/etc/hadoop

ENV HADOOP_ROOT_LOGGER=debug,console
ENV HDFS_DATANODE_USER=root
ENV HDFS_DATANODE_SECURE_USER=root
ENV HDFS_NAMENODE_USER=root
ENV HDFS_SECONDARYNAMENODE_USER=root
ENV YARN_RESOURCEMANAGER_USER=root
ENV YARN_NODEMANAGER_USER=root

ADD hadoop-3.2.0.tar.gz /usr/local

RUN cp -R $HADOOP_HOME/etc/hadoop $HADOOP_CONF_DIR && \
    sed -i "/# export JAVA_HOME=/a export JAVA_HOME=$JAVA_HOME" $HADOOP_CONF_DIR/hadoop-env.sh && \
    ln -s $HADOOP_HOME/bin/* /usr/local/bin && \
    ln -s $HADOOP_HOME/sbin/* /usr/local/bin

COPY *.xml $HADOOP_CONF_DIR/

# sshd
EXPOSE 22
# namenode web ui
EXPOSE 50070
# resourcemanager web ui
EXPOSE 8088
# history server
EXPOSE 19888

WORKDIR $HADOOP_HOME

# 1 namenode, 1 SecondaryNameNode，a DataNode, a ResourceManager
# 1 NodeManager
# 1 JobHistoryServer
CMD /usr/sbin/sshd && \
    # format fs
    bash $HADOOP_HOME/bin/hdfs namenode -format && \
    bash $HADOOP_HOME/sbin/start-dfs.sh && \
    bash $HADOOP_HOME/sbin/start-yarn.sh && \
    #bash $HADOOP_HOME/bin/mapred --daemon start && \
    bash $HADOOP_HOME/sbin/mr-jobhistory-daemon.sh start historyserver && \
    bash

# hadoop fs -mkdir -p /user/$(whoami)




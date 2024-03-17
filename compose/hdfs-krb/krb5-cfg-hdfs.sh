#!/bin/bash

HADOOP_HOME=${HADOOP_HOME=/opt/hadoop-3.2.1}
# core-site.xml
cat <<EOF > core-site.xml.tmp
<property>
    <name>hadoop.security.authorization</name>
    <value>true</value>
</property>
<property>
    <name>hadoop.security.authentication</name>
    <value>kerberos</value>
</property>
<property>
  <name>ignore.secure.ports.for.testing</name>
  <value>true</value>
</property>
EOF
sed -i '/<\/configuration>/e cat core-site.xml.tmp' $HADOOP_HOME/etc/hadoop/core-site.xml
rm -f core-site.xml.tmp

# hdfs-site.xml
cat <<EOF > hdfs-site.xml.tmp
<property>
  <name>dfs.block.access.token.enable</name>
  <value>true</value>
</property>
<property>
  <name>dfs.namenode.keytab.file</name>
  <value>/etc/hdfs.keytab</value>
</property>
<property>
  <name>dfs.namenode.kerberos.principal</name>
  <value>${HDFS_PRINCIPAL}</value>
</property>
<property>
  <name>dfs.namenode.kerberos.https.principal</name>
  <value>${HTTP_PRINCIPAL}</value>
</property>
<property>
  <name>dfs.datanode.keytab.file</name>
  <value>/etc/hdfs.keytab</value>
</property>
<property>
  <name>dfs.datanode.kerberos.principal</name>
  <value>${HDFS_PRINCIPAL}</value>
</property>
<property>
  <name>dfs.datanode.kerberos.https.principal</name>
  <value>${HTTP_PRINCIPAL}</value>
</property>
<property>
  <name>dfs.web.authentication.kerberos.keytab</name>
  <value>/etc/hdfs.keytab</value>
</property>
<property>
  <name>dfs.web.authentication.kerberos.principal</name>
  <value>${HTTP_PRINCIPAL}</value>
</property>
EOF
sed -i '/<\/configuration>/e cat hdfs-site.xml.tmp' $HADOOP_HOME/etc/hadoop/hdfs-site.xml
rm -f hdfs-site.xml.tmp

# mapred-site.xml
cat <<EOF > mapred-site.xml.tmp
<property>
  <name>mapreduce.jobhistory.keytab</name>
  <value>/etc/hdfs.keytab</value>
</property>
<property>
  <name>mapreduce.jobhistory.principal</name>
  <value>${HDFS_PRINCIPAL}</value>
</property>
EOF
sed -i '/<\/configuration>/e cat mapred-site.xml.tmp' $HADOOP_HOME/etc/hadoop/mapred-site.xml
rm -f mapred-site.xml.tmp

# yarn-site.xml
cat <<EOF > yarn-site.xml.tmp
<property>
  <name>yarn.resourcemanager.keytab</name>
  <value>/etc/hdfs.keytab</value>
</property>
<property>
  <name>yarn.resourcemanager.principal</name>
  <value>${HDFS_PRINCIPAL}</value>
</property>
<property>
  <name>yarn.nodemanager.keytab</name>
  <value>/etc/hdfs.keytab</value>
</property>
<property>
  <name>yarn.nodemanager.principal</name>
  <value>${HDFS_PRINCIPAL}</value>
</property>
EOF
sed -i '/<\/configuration>/e cat yarn-site.xml.tmp' $HADOOP_HOME/etc/hadoop/yarn-site.xml
rm -f yarn-site.xml.tmp


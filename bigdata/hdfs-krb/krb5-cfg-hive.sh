#!/bin/bash

# hive-site.xml
cat <<EOF > hive-site.xml.tmp
<property>
  <name>hive.security.authorization.enabled</name>
  <value>true</value>
</property>
<property>
  <name>hive.server2.authentication</name>
  <value>kerberos</value>
</property>
<property>
  <name>hive.server2.authentication.kerberos.principal</name>
  <value>${HIVE_PRINCIPAL}</value>
</property>
<property>
  <name>hive.server2.authentication.kerberos.keytab</name>
  <value>/etc/hive.keytab</value>
</property>
<property>
  <name>hive.metastore.sasl.enabled</name>
  <value>true</value>
</property>
<property>
  <name>hive.metastore.kerberos.keytab.file</name>
  <value>/etc/hive.keytab</value>
</property>
<property>
  <name>hive.metastore.kerberos.principal</name>
  <value>${HIVE_PRINCIPAL}</value>
</property>
EOF

sed -i '/<\/configuration>/e cat hive-site.xml.tmp' $HIVE_HOME/conf/hive-site.xml
rm -f hive-site.xml.tmp

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
  <name>hadoop.proxyuser.hive.hosts</name>
  <value>*</value>
</property>
<property>
  <name>hadoop.proxyuser.hive.groups</name>
  <value>*</value>
</property>
<property>
  <name>hadoop.proxyuser.hdfs.hosts</name>
  <value>*</value>
</property>
<property>
  <name>hadoop.proxyuser.hdfs.groups</name>
  <value>*</value>
</property>
<property>
  <name>hadoop.proxyuser.HTTP.hosts</name>
  <value>*</value>
</property>
<property>
  <name>hadoop.proxyuser.HTTP.groups</name>
  <value>*</value>
</property>
EOF
sed -i '/<\/configuration>/e cat core-site.xml.tmp' $HADOOP_HOME/etc/hadoop/core-site.xml
rm -f core-site.xml.tmp

# yarn-site.xml
cat <<EOF > $HIVE_HOME/conf/yarn-site.xml
<?xml version="1.0" encoding="UTF-8"?>

<configuration>
 <property>
    <name>yarn.resourcemanager.principal</name>
    <value>${HIVE_PRINCIPAL}</value>
  </property>
</configuration>
EOF

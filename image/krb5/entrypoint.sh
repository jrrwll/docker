#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

export KERBEROS_PASSWORD=${KERBEROS_PASSWORD=kerberos}
export DEFAULT_REALM=${DEFAULT_REALM=MY.DOMAIN}
export DEFAULT_DOMAIN=${DEFAULT_DOMAIN=my.domain}

if [ -f /var/lib/krb5kdc/principal ]; then
  service krb5-kdc start
  service krb5-admin-server start
  echo "krb5 already created new realm, skip it..."
  tail -f /var/log/krb5kdc.log /var/log/kadmin.log
  exit 0
fi

## no need it, since dns_lookup_kdc is false
#cp /etc/hosts ~/hosts.new
#sed -i "/^127.0.0.1/ s/\$/ $DEFAULT_DOMAIN/" ~/hosts.new
#sed -i "/^::1/ s/\$/ $DEFAULT_DOMAIN/" ~/hosts.new
#cp -f ~/hosts.new /etc/hosts

[ ! -d /etc/krb5kdc ] && mkdir /etc/krb5kdc
echo "*/admin *" >> /etc/krb5kdc/kadm5.acl

cat > /etc/krb5.conf <<EOF
[libdefaults]
    udp_preference_limit = 1
    # kdc_ports = 88
    # kdc_tcp_ports = 88
    default_realm = ${DEFAULT_REALM^^}
    dns_lookup_realm = false
    dns_lookup_kdc = false
    ticket_lifetime = 24h
    ## uncomment it is will cause: Message stream modified (41)
    # or you can keep this by do: kadmin.local modprinc -maxrenewlife 90day +allow_renewable your_principal@EXAMPLE.COM
    # renew_lifetime = 7d
    forwardable = true
    allor_weak_crypto = true
[realms]
    ${DEFAULT_REALM^^} = {
        kdc = $DEFAULT_DOMAIN
        admin_server = $DEFAULT_DOMAIN
    }
[domain_realm]
    .$DEFAULT_DOMAIN = ${DEFAULT_REALM^^}
    $DEFAULT_DOMAIN = ${DEFAULT_REALM^^}
[logging]
    kdc = FILE:/var/log/krb5kdc.log
    admin_server = FILE:/var/log/kadmin.log
    default = FILE:/var/log/krb5lib.log
EOF

#kdb5_util create -P $KERBEROS_PASSWORD
printf "$KERBEROS_PASSWORD\n$KERBEROS_PASSWORD" | krb5_newrealm

#service krb5-kdc start
#service krb5-admin-server start

kadmin.local add_principal -pw ${EXTRA_PASSWORD=mypassword} ${EXTRA_USER=myuser}
kadmin.local add_principal -pw ${EXTRA_PASSWORD=mypassword} ${EXTRA_USER=myuser}/admin

tail -f /var/log/krb5kdc.log /var/log/kadmin.log

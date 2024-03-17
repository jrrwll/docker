FROM jerrywill/debian:9

MAINTAINER "tuke tukeof@gmail.com"

RUN apt-get update && apt-get install krb5-kdc krb5-admin-server -y

COPY entrypoint.sh /

# KDC udp port
EXPOSE 88/tcp
EXPOSE 88/udp
EXPOSE 464/tcp
EXPOSE 464/udp
EXPOSE 749/tcp
EXPOSE 749/udp

# KERBEROS_PASSWORD
# DEFAULT_REALM
# DEFAULT_DOMAIN
CMD ["/bin/bash", "/entrypoint.sh"]

# docker build -t jerrywill/krb5 .
# docker run -it -d --name krb5 -p 88:88 -p 464:464 -p 749:749 jerrywill/krb5 /bin/bash /krb5.sh
# docker exec -it krb5 kadmin.local list_principals

FROM httpd:2.4
LABEL maintainer="Andy Lo-A-Foe at aemian dot com"

# For information about these parameters see 
# https://httpd.apache.org/docs/2.4/mod/mod_authnz_ldap.html
ARG AuthLDAPURL
ARG AuthLDAPBindDN
ARG AuthLDAPBindPassword

RUN apt-get update && apt-get --yes --force-yes --no-install-recommends install curl subversion libapache2-mod-svn \
    && rm -rf /var/lib/apt/lists/*
COPY entrypoint.sh /my-docker-entrypoint.sh
RUN chmod 755 /my-docker-entrypoint.sh

WORKDIR /usr/local/apache2
RUN echo "Include conf/extra/docker.conf" >> conf/httpd.conf

VOLUME ["/var/svn"]
ENTRYPOINT ["/my-docker-entrypoint.sh"]
CMD ["httpd-foreground"]

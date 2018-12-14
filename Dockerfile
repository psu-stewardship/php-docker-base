FROM ubuntu:bionic

COPY webaccess_3.3.0_amd64.deb /tmp
RUN /bin/sh -c apt-get update \
    &&     apt-get install apache2 libssl1.0.0 libssl-dev -y \
    &&      dpkg -i /tmp/webaccess_3.3.0_amd64.deb
COPY apache-foreground /usr/local/bin
RUN /bin/sh -c sed -i 's/^ErrorLog.*/ErrorLog \/proc\/self\/fd\/1/g' /etc/apache2/apache2.conf
RUN /bin/sh -c sed -i 's/\tCustomLog.*/\tCustomLog \/proc\/self\/fd\/1 combined/g' /etc/apache2/sites-available/000-default.conf
CMD ["apache-foreground"]

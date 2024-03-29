FROM ubuntu:bionic

LABEL maintainer="djb44@psu.edu"

COPY webaccess_3.3.0_amd64.deb /tmp
RUN apt-get update \
    && apt-get install ca-certificates apache2 libssl1.0.0 libssl-dev -y \
    && apt-get upgrade -y  \
    && rm -rf /var/lib/apt/lists/* 
RUN dpkg -i /tmp/webaccess_3.3.0_amd64.deb
COPY apache-foreground /usr/local/bin
RUN sed -i 's/^ErrorLog.*/ErrorLog \/proc\/self\/fd\/1/g' /etc/apache2/apache2.conf
RUN sed -i 's/\tCustomLog.*/\tCustomLog \/proc\/self\/fd\/1 combined/g' /etc/apache2/sites-available/000-default.conf

CMD ["apache-foreground"]

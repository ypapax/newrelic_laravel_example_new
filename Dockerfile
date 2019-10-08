FROM ubuntu
RUN apt-get update
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:ondrej/php
RUN apt-get update
RUN echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu bionic main" | tee /etc/apt/sources.list.d/docker.list
RUN echo "deb-src http://ppa.launchpad.net/ondrej/php/ubuntu bionic main" | tee /etc/apt/sources.list.d/docker.list

ENV DEBIAN_FRONTEND=noninteractive

RUN ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime
RUN apt-get install -y tzdata
RUN dpkg-reconfigure --frontend noninteractive tzdata
RUN apt-get install -y curl

RUN apt-get install php7.3 -y
RUN php -v

WORKDIR /root
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer
RUN which composer
RUN apt-get install php-mbstring -y
RUN apt-get install php-xml -y
RUN apt-get install sudo -y
RUN apt-get install wget -y
RUN adduser --disabled-password --gecos '' newuser
RUN echo 'deb http://apt.newrelic.com/debian/ newrelic non-free' | sudo tee /etc/apt/sources.list.d/newrelic.list
RUN wget -O- https://download.newrelic.com/548C16BF.gpg | sudo apt-key add -
RUN sudo apt-get update
ARG PROJ
ARG NEWRELIC_LICENSE_KEY
RUN echo newrelic-php5 newrelic-php5/application-name string "$PROJ" | debconf-set-selections

RUN ls -lah && echo NEWRELIC_LICENSE_KEY $NEWRELIC_LICENSE_KEY
RUN echo newrelic-php5 newrelic-php5/license-key string "$NEWRELIC_LICENSE_KEY" | debconf-set-selections
RUN sudo apt-get install newrelic-php5 -y
EXPOSE 8000
COPY . $PROJ
WORKDIR $PROJ
CMD php artisan serve --host 0.0.0.0 --port 8000

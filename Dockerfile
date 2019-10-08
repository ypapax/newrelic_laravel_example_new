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

#RUN curl --silent --show-error https://getcomposer.org/installer | php
WORKDIR /root
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer
RUN which composer
RUN apt-get install php-mbstring -y
RUN apt-get install php-xml -y
RUN apt-get install sudo -y
RUN adduser --disabled-password --gecos '' newuser
#COPY php.ini /etc/php/7.3/cli/php.ini
EXPOSE 8000
ENV PROJ=lara
COPY . $PROJ
WORKDIR $PROJ
CMD php artisan serve --host 0.0.0.0 --port 8000

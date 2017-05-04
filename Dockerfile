FROM ubuntu:trusty

MAINTAINER kevell

RUN echo "deb http://ppa.launchpad.net/nginx/stable/ubuntu trusty main" > /etc/apt/sources.list.d/nginx-stable-trusty.list

RUN echo "deb-src http://ppa.launchpad.net/nginx/stable/ubuntu trusty main" >> /etc/apt/sources.list.d/nginx-stable-trusty.list

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C300EE8C

RUN apt-get update

RUN apt-get install nginx -y && \
    rm -rf /var/lib/apt/lists/* && \
    echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
    chown -R www-data:www-data /var/lib/nginx

VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx", "/var/www/html"]

WORKDIR /etc/nginx

RUN apt-get update
RUN apt-get install -y curl

RUN curl --silent --location https://deb.nodesource.com/setup_7.x | sudo bash -

RUN apt-get install --yes nodejs

RUN apt-get install --yes build-essential

RUN apt-get update

#RUN apt-get install -y npm 
#RUN apt-get install nodejs-legacy -y

RUN npm install -g bower -y

RUN npm install -g grunt

RUN npm install -g grunt-cli


#COPY . /src

#RUN cd /src; npm install

EXPOSE 8080 
EXPOSE 80
EXPOSE 443

CMD ["node", "/src/index.js"]
CMD ["nginx"]

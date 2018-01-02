# Build:
# docker build -t meteor-production .
#
# Run:
# docker run --name dockerMeteorProduction meteor-production -s
#
# Compose:
# docker-compose up -d

FROM ubuntu:latest
MAINTAINER RoHscx


# 80 = HTTP, 443 = HTTPS, 3000 = Meteor.JS server 8080 = node-inspector
EXPOSE 80 8080 443 3000


# Set development environment as default
ENV NODE_ENV development


# Install Utilities
RUN apt-get update \
&& apt-get install -qy curl \
 locales \
 git \
 apt-utils\
 build-essential \
 vim \
 npm
RUN apt-get clean \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
&& locale-gen en_US.UTF-8


# Install Nodejs on Ubuntu systems
# Version must match Meteor Application requirements. meteor node -v
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs

# Install Meteor.js
 RUN curl https://install.meteor.com/ | sh

# Install mongodb on Ubuntu Systems
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6 \
&& echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.4.list
RUN apt-get update \
&& apt-get install -y mongodb-org


# Make mongo db directory
RUN mkdir -p /data/db
RUN chmod 0777 /data/db

# Add Meteor user
RUN adduser --disabled-password --gecos "" node_dev

# Run Entrypoint script
COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT [ "/docker-entrypoint.sh" ]
RUN chmod 755 /docker-entrypoint.sh

# Switch to Meteor user and create working directory
USER node_dev
RUN cd ~/ \
&& mkdir nodeProjects

# Set Docker working directory
WORKDIR /home/node_dev/nodeProjects

# Copy Meteor application bundle to container
COPY meteor-app.tar.gz /home/node_dev/nodeProjects
COPY settings.json /home/node_dev/nodeProjects

# Run bash
CMD [ "-s" ]

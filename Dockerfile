FROM ubuntu:14.04
MAINTAINER Evgeniy Semenov <e.semenov@corp.mail.ru>

#===============================
# Customize sources for apt-get
#===============================
RUN echo "deb http://archive.ubuntu.com/ubuntu trusty main universe\n" > /etc/apt/sources.list \
    && echo "deb http://archive.ubuntu.com/ubuntu trusty-updates main universe\n" >> /etc/apt/sources.list

#==============================================
# Miscellaneous packages
# Includes Android SDK dependencies and NodeJS
#==============================================
RUN dpkg --add-architecture i386 \
    && apt-get update -qqy \
    && apt-get install -qqy --no-install-recommends \
        wget \
        zip \
        nodejs \
        npm \
        openjdk-7-jre-headless \
        libc6-i386 \
        lib32stdc++6 \
        lib32gcc1 \
        lib32ncurses5 \
        lib32z1 \
    && rm -rf /var/lib/apt/lists/*

#========================
# Fix debian node naming
#========================
RUN update-alternatives --install /usr/bin/node node /usr/bin/nodejs 10

#=====================
# Install Android SDK
#=====================
RUN wget -qO- "http://dl.google.com/android/android-sdk_r24.0.2-linux.tgz" | tar -zxv -C /opt/ \
    && echo y | /opt/android-sdk-linux/tools/android update sdk \
        --all --filter platform-tools,build-tools-20.0.0 \
        --no-ui --force
ENV ANDROID_HOME /opt/android-sdk-linux

#====================
# Create appium user
#====================
RUN mkdir /opt/appium \
    && useradd -m -s /bin/bash appium \
    && chown -R appium:appium /opt/appium

#================
# Install appium
#================
USER appium
ENV HOME /home/appium
ENV APPIUM_VERSION 1.3.7
RUN cd /opt/appium && npm install appium@${APPIUM_VERSION}

#===================
# Run appium server
#===================
CMD /opt/appium/node_modules/appium/bin/appium.js $APPIUM_ARGS

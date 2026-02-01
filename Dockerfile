FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV ENV=ci

# Dependencias base
RUN apt-get update && apt-get install -y \
    python3 python3-pip \
    curl unzip wget \
    openjdk-17-jdk \
    adb \
    nodejs npm \
    && rm -rf /var/lib/apt/lists/*

# Appium
RUN npm install -g appium
RUN appium driver install uiautomator2

# Robot Framework
RUN pip3 install --no-cache-dir \
    robotframework \
    robotframework-appiumlibrary

WORKDIR /app
COPY . /app

RUN chmod +x scripts/run-tests.sh

EXPOSE 4723

CMD ["bash", "scripts/run-tests.sh"]

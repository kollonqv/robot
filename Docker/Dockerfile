FROM python:3.8
USER root

# install chrome dependencies 
RUN apt-get update && apt-get install -y xvfb wget ca-certificates fonts-liberation libasound2 libatk-bridge2.0-0 libatk1.0-0 \
       libatspi2.0-0 libcups2 libdbus-1-3 libgbm1 libgtk-3-0 libnspr4 libnss3 \
       libxcomposite1 libxkbcommon0 libxrandr2 xdg-utils ntpdate openssl

# install required python packages
RUN python3 -m pip install robotframework && python3 -m pip install robotframework-selenium2library \
    && python3 -m pip install robotframework-selenium2library \
    && python3 -m pip install requests

# download and install chrome and chrome driver
RUN wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
    && dpkg -i google-chrome*.deb \
    && rm google-chrome*.deb \
    && wget -q https://chromedriver.storage.googleapis.com/98.0.4758.102/chromedriver_linux64.zip \
    && unzip chromedriver_linux64.zip \
    && rm chromedriver_linux64.zip \
    && mv chromedriver /usr/local/bin \
    && chmod +x /usr/local/bin/chromedriver

RUN groupadd -r tester -g 1000 \
    && useradd --no-log-init -r -g tester tester -ms /bin/bash -u 1000

ENV PATH=$PATH:/opt/webdrivers:/home/tester/.local/bin

USER tester
WORKDIR /home/tester

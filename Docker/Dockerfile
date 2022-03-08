# FROM python:3.8
# USER root

# # install chrome dependencies 
# RUN apt-get update && apt-get install -y xvfb wget ca-certificates fonts-liberation libasound2 libatk-bridge2.0-0 libatk1.0-0 \
#        libatspi2.0-0 libcups2 libdbus-1-3 libgbm1 libgtk-3-0 libnspr4 libnss3 \
#        libxcomposite1 libxkbcommon0 libxrandr2 xdg-utils ntpdate openssl

# # install required python packages
# RUN python3 -m pip install robotframework && python3 -m pip install robotframework-selenium2library \
#     && python3 -m pip install robotframework-selenium2library \
#     && python3 -m pip install requests

# # download and install chrome and chrome driver
# RUN wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
#     && dpkg -i google-chrome*.deb \
#     && rm google-chrome*.deb \
#     && wget -q https://chromedriver.storage.googleapis.com/99.0.4844.51/chromedriver_linux64.zip \
#     && unzip chromedriver_linux64.zip \
#     && rm chromedriver_linux64.zip \
#     && mv chromedriver /usr/local/bin \
#     && chmod +x /usr/local/bin/chromedriver

# # Setup X Window Virtual Framebuffer
# ENV SCREEN_COLOUR_DEPTH 24
# ENV SCREEN_HEIGHT 1080
# ENV SCREEN_WIDTH 1920

# # set timezone
# ENV TZ GMT+2

# RUN chmod +x /opt/bin/entry_point.sh

# # ENV PATH=$PATH:/opt/webdrivers:/home/tester/.local/bin

# # USER tester
# # WORKDIR /home/tester

FROM python:3.9.0-alpine3.12

# Setup X Window Virtual Framebuffer
ENV SCREEN_COLOUR_DEPTH 24
ENV SCREEN_HEIGHT 1080
ENV SCREEN_WIDTH 1920

# Setup the timezone to use, defaults to UTC
ENV TZ UTC

COPY chromedriver.sh /opt/robotframework/bin/chromedriver
COPY chromium-browser.sh /opt/robotframework/bin/chromium-browser
COPY run-tests-in-virtual-screen.sh /opt/robotframework/bin/

RUN apk update \
  && apk --no-cache upgrade \
  && apk --no-cache --virtual .build-deps add \

    # Install dependencies for cryptography due to https://github.com/pyca/cryptography/issues/5771
    cargo \
    rust \

    # Continue with system dependencies
    gcc \
    g++ \
    libffi-dev \
    linux-headers \
    make \
    musl-dev \
    openssl-dev \
    which \
    wget \
  && apk --no-cache add \
    chromium \
    chromium-chromedriver \
    firefox-esr \
    nodejs \
    nodejs-npm \
    xauth \
    tzdata \
    xvfb-run \
  && mv /usr/lib/chromium/chrome /usr/lib/chromium/chrome-original \
  && ln -sfv /opt/robotframework/bin/chromium-browser /usr/lib/chromium/chrome \
# FIXME: above is a workaround, as the path is ignored

# Install Robot Framework and Selenium Library
  && pip3 install \
    --no-cache-dir \
    robotframework \
    robotframework-requests \
    robotframework-seleniumlibrary \

# Download the glibc package for Alpine Linux from its GitHub repository
  && wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
    && wget -q "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/$ALPINE_GLIBC/glibc-$ALPINE_GLIBC.apk" \
    && wget -q "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/$ALPINE_GLIBC/glibc-bin-$ALPINE_GLIBC.apk" \
    && apk add glibc-$ALPINE_GLIBC.apk \
    && apk add glibc-bin-$ALPINE_GLIBC.apk \
    && rm glibc-$ALPINE_GLIBC.apk \
    && rm glibc-bin-$ALPINE_GLIBC.apk \
    && rm /etc/apk/keys/sgerrand.rsa.pub \

# Download Gecko drivers directly from the GitHub repository
  && wget -q "https://github.com/mozilla/geckodriver/releases/download/$GECKO_DRIVER_VERSION/geckodriver-$GECKO_DRIVER_VERSION-linux64.tar.gz" \
    && tar xzf geckodriver-$GECKO_DRIVER_VERSION-linux64.tar.gz \
    && mkdir -p /opt/robotframework/drivers/ \
    && mv geckodriver /opt/robotframework/drivers/geckodriver \
    && rm geckodriver-$GECKO_DRIVER_VERSION-linux64.tar.gz \

# Clean up buildtime dependencies
  && apk del --no-cache --update-cache .build-deps


ENV PATH=/opt/robotframework/bin:/opt/robotframework/drivers:$PATH

CMD ["run-tests-in-virtual-screen.sh"]
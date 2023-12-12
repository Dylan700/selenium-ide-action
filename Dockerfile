FROM node:20

# installing chrome
USER root
RUN apt-get update && apt-get install -y \
    fonts-liberation libasound2 libatk-bridge2.0-0 libatk1.0-0 libatspi2.0-0 libcups2 libdbus-1-3 libdrm2 libgbm1 \
    libgtk-3-0 libnspr4 libnss3 libu2f-udev libvulkan1 libxcomposite1 libxdamage1 libxfixes3 libxkbcommon0 libxrandr2 \
    xdg-utils wget --no-install-recommends \
    && wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
    && dpkg -i google-chrome-stable_current_amd64.deb \
    && apt-get install -f \
    && rm -rf /var/lib/apt/lists/* \
    && rm google-chrome-stable_current_amd64.deb

RUN google-chrome --version

# installing dependencies
RUN npm install -g selenium-side-runner@4.0.0-alpha.57 # we are using this version because of https://github.com/SeleniumHQ/selenium-ide/issues/1536#issuecomment-1312421875
RUN npm install -g jest-junit
RUN apt-get update && apt-get install jq -y

USER node

WORKDIR /home/node

COPY entrypoint.sh .

ENTRYPOINT ["./entrypoint.sh"]

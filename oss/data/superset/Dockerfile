FROM apache/superset:3.1.3

USER root

RUN apt-get update && \
    apt-get install --no-install-recommends -y wget && \
    wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    apt-get install -y --no-install-recommends ./google-chrome-stable_current_amd64.deb && \
    rm -f google-chrome-stable_current_amd64.deb && \
    apt-get remove -y wget

RUN apt-get install --no-install-recommends -y wget unzip && \
    export CHROMEDRIVER_VERSION=$(curl --silent https://chromedriver.storage.googleapis.com/LATEST_RELEASE_102) && \
    wget -q https://chromedriver.storage.googleapis.com/${CHROMEDRIVER_VERSION}/chromedriver_linux64.zip && \
    unzip chromedriver_linux64.zip -d /usr/bin && \
    chmod 755 /usr/bin/chromedriver && \
    rm -f chromedriver_linux64.zip && \
    apt-get remove -y wget unzip

RUN pip install --no-cache gevent psycopg2 redis

USER superset

# docker build -t jerrywill/superset:3.1.3-chrome .
# docker push jerrywill/superset:3.1.3-chrome

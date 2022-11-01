FROM ubuntu:jammy

RUN apt-get update && \
    apt-get install -y python3-pip curl 
RUN cd / && \
    curl -sL https://github.com/getzola/zola/releases/download/v0.16.1/zola-v0.16.1-x86_64-unknown-linux-gnu.tar.gz | tar zxv

COPY ./blog /blog
RUN cd /blog/ && \
    python3 -m pip install --user -r requirements.txt && \
    python3 ./before_build.py && \
    /zola build

WORKDIR /blog/public/
CMD ["python3", "-m", "http.server", "80"]

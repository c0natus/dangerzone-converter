FROM ubuntu:20.04

RUN DEBIAN_FRONTEND=noninteractive && \
    export DEBIAN_FRONTEND && \
    apt-get update && \
    apt-get install --yes --no-install-recommends \
        ghostscript \
        graphicsmagick \
        libreoffice \
        poppler-utils \
        python3 \
        python3-magic \
        python3-pil \
        sudo \
        tesseract-ocr \
        tesseract-ocr-all \
        python3-pip \
        xvfb \
        xfonts-100dpi \
        xfonts-75dpi \
        xfonts-scalable \
        xfonts-cyrillic \
        wkhtmltopdf \
        flashplugin-nonfree \
        language-pack-ko \ 
        fonts-nanum \
        fonts-nanum-coding \ 
        fonts-nanum-extra \
        fcitx-hangul \
        && \
    pip3 install --pre pyhwp six && \
    locale-gen ko_KR.UTF-8 && \
    apt-get upgrade --yes && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    useradd --no-log-init --create-home --shell /bin/bash user

ENV LANG="en_US.UTF-8":"ko_KR.UTF-8"
ENV LANGUAGE = "ko_KR:ko:en_GB:en"

COPY scripts/* /usr/local/bin/

# /tmp is where the first convert expects the input file to be, and
# where it will write the pixel files
#
# /dangerzone is where the second script expects files to be put by the first one
#
# /safezone is where the wrapper eventually moves the sanitized files.
VOLUME /dangerzone /tmp /safezone

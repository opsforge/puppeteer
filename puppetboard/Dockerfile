FROM python:2.7-wheezy
MAINTAINER George Svachulay "george.svachulay@opsforge.io"

LABEL org.label-schema.vendor="OSS" \
      org.label-schema.name="Puppetboard" \
      org.label-schema.license="Apache-2.0" \
      com.puppet.dockerfile="/Dockerfile" \
      name="puppetboard" \
      version="0.2.0"

ENV PUPPETBOARD_PORT 80
ENV PUPPETBOARD_SETTINGS docker_settings.py
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY requirements-docker.txt /usr/src/app/
RUN pip install --no-cache-dir -r requirements-docker.txt
COPY . /usr/src/app

CMD gunicorn -b 0.0.0.0:${PUPPETBOARD_PORT} --access-logfile=/dev/stdout puppetboard.app:app

ARG PYTHON_VERSION=3.14
ARG ALPINE_VERSION=3.22
ARG TAG=${PYTHON_VERSION}-alpine${ALPINE_VERSION}
FROM python:${TAG}

ARG USER=app
ARG UID=1000

RUN adduser -D -s /bin/sh -u ${UID} ${USER}
WORKDIR /app
ADD requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
RUN chown -R ${USER}:${USER} /app
USER ${USER}
EXPOSE 9179

ENTRYPOINT ["python", "-u", "mongodb-profiler-exporter.py"]

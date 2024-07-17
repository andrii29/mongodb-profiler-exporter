ARG TAG=3.12-alpine3.20
FROM python:${TAG}

ARG USER=app
ARG UID=1000

RUN adduser -D -s /bin/bash -u ${UID} ${USER}
WORKDIR /app
ADD requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
RUN chown -R ${USER}:${USER} /app
USER ${USER}
EXPOSE 9179

ENTRYPOINT ["python", "mongodb-profiler-exporter.py"]

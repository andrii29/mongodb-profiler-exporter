FROM python:3.12-slim

ARG USER=app
ARG UID=1000

RUN useradd -ms /bin/bash ${USER} --uid ${UID}
WORKDIR /app
ADD requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
RUN chown -R ${USER}:${USER} /app
USER ${USER}
EXPOSE 9179

ENTRYPOINT ["python", "mongodb-profiler-exporter.py"]

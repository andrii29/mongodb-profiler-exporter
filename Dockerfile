FROM python:3.12-slim

WORKDIR /app
ADD requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . /app

EXPOSE 9179

ENTRYPOINT ["python", "mongodb-profiler-exporter.py"]

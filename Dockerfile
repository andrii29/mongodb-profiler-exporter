FROM python:3.8

WORKDIR /app
ADD requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . /app

EXPOSE 9179

CMD ["python", "mongodb-profiler-exporter.py"]

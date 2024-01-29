## MongoDB Profiler Prometheus Exporter
A Python script that exports MongoDB slow query metrics from system.profile collection for Prometheus monitoring.

### Installation
```bash
pip install -r requirements.txt
python mongodb-profiler-exporter.py
```

### Docker
```
docker build -t mongodb-profiler-exporter .
docker run -p 9179:9179 host -it --rm --net host --name mongodb-profiler-exporter mongodb-profiler-exporter # host network
docker run -p 9179:9179 host -it --rm --name mongodb-profiler-exporter mongodb-profiler-exporter

```

### Usage
```
usage: mongodb-profiler-exporter.py [-h] [--uri URI] [--wait-interval WAIT_INTERVAL] [--max-string-size MAX_STRING_SIZE] [--listen-ip LISTEN_IP] [--listen-port LISTEN_PORT]
                                    [--metrics-endpoint METRICS_ENDPOINT]

MongoDB Prometheus Exporter

options:
  -h, --help            show this help message and exit
  --uri URI             MongoDB URI (default: mongodb://127.0.0.1:27017/) (default: mongodb://127.0.0.1:27017/)
  --wait-interval WAIT_INTERVAL
                        Wait interval between data parsing in seconds (default: 10)
  --max-string-size MAX_STRING_SIZE
                        Maximum string size for Prometheus labels (default: 1000)
  --listen-ip LISTEN_IP
                        IP address to listen on (default: 0.0.0.0)
  --listen-port LISTEN_PORT
                        Port to listen (default: 9179) (default: 9179)
  --metrics-endpoint METRICS_ENDPOINT
                        Metrics endpoint path (default: /metrics)
```

#### Environment Variables

You can use environment variables to configure the exporter. If an environment variable is set, it takes precedence over the corresponding command-line argument.

- `MONGODB_URI`: MongoDB URI (default: `mongodb://127.0.0.1:27017/`)
- `WAIT_INTERVAL`: Wait interval between data parsing in seconds (default: `10`)
- `MAX_STRING_SIZE`: Maximum string size for Prometheus labels (default: `1000`)
- `LISTEN_IP`: IP address to listen on (default: `0.0.0.0`)
- `LISTEN_PORT`: Port to listen (default: `9179`)
- `METRICS_ENDPOINT`: Metrics endpoint path (default: `/metrics`)

### Authentication
To set up authentication, follow these steps:
```bash
mongosh

use admin
db.createUser({
  user: "mongodb-profiler-exporter",
  pwd: passwordPrompt(),
  roles: [
    { role: "read", db: "admin" },
    { role: "read", db: "local" },
    { role: "read", db: "config" },
    { role: "read", db: "your_database" }
  ]
})

python mongodb-profiler-exporter.py --uri "mongodb://mongodb-profiler-exporter:<password>@127.0.0.1:27017/"


```

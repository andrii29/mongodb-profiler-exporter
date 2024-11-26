```
cat .env
docker network create tests --subnet 172.14.24.0/24
docker compose up -d
docker compose  exec mongodb bash /scripts/prepare.sh
docker compose  exec mongodb bash /scripts/query.sh
http://127.0.0.1:3000
docker compose logs mongodb-profiler-exporter -f
docker compose down
```

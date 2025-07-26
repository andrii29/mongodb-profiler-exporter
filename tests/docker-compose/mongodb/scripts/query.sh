#!/bin/sh

# Determine which MongoDB client to use
if command -v mongosh >/dev/null 2>&1; then
    MONGO_CMD="mongosh"
elif command -v mongo >/dev/null 2>&1; then
    MONGO_CMD="mongo"
else
    echo "Error: Neither mongosh nor mongo command found"
    exit 1
fi

echo "Using MongoDB client: $MONGO_CMD"

while true; do
    # Generate a random number between 1 and 10 for selecting a query
    random_query=$((RANDOM % 10 + 1))

    case $random_query in
        1)
            query='db.app.find({"app": 1})'
            ;;
        2)
            query='db.app.find({"host": {"$gt": 5}})'
            ;;
        3)
            query='db.app.find({"guest": {"$lt": 15}})'
            ;;
        4)
            query='db.app.find({"host": {"$eq": 9}}).sort({host:1, app: -1})'
            ;;
        5)
            query='db.app.aggregate([{"$group": {"_id": "$app", "count": {"$sum": 1}}}, {"$sort": {"count": -1}}])'
            ;;
        6)
            query='db.app.aggregate([{"$project": {"guest": 1, "host": 1}}, {"$sort": {"host": 1}}])'
            ;;
        7)
            query='db.app.aggregate([{"$match": {"host": 1}}, {"$group": {"_id": "$host", "avg_host": {"$avg": "$host"}}}])'
            ;;
        8)
            query='db.app.find().limit(5)'
            ;;
        9)
            query='db.app.aggregate([{"$group": {"_id": null, "total_guest": {"$sum": "$guest"}}}])'
            ;;
        10)
            query='db.app.find({"host": {"$gte": 5}, "app": {"$lt": 15}})'
            ;;
        *)
            echo "Invalid random_query number"
            continue
            ;;
    esac

    $MONGO_CMD "mongodb://127.0.0.1:27017/rto" --eval "$query"

    sleep 0.1
done

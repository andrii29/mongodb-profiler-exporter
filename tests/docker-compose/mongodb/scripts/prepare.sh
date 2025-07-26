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

echo "Generate Random Data"
$MONGO_CMD "mongodb://127.0.0.1:27017/rto" /scripts/generate_random_data.js
echo "Create Index"
$MONGO_CMD "mongodb://127.0.0.1:27017/rto" --eval "db.app.createIndex({ guest: 1 })"
echo "Enable Profiler"
$MONGO_CMD "mongodb://127.0.0.1:27017/rto" --eval "db.setProfilingLevel(2)"

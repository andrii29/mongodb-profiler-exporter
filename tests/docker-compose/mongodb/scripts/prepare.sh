#!/bin/sh

echo "Generate Random Data"
mongosh "mongodb://127.0.0.1:27017/rto" /scripts/generate_random_data.js
echo "Create Index"
mongosh "mongodb://127.0.0.1:27017/rto" --eval "db.app.createIndex({ guest: 1 })"
echo "Enable Profiler"
mongosh "mongodb://127.0.0.1:27017/rto" --eval "db.setProfilingLevel(2)"

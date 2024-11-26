var bulkOps = [];

for (var i = 0; i < 1000000; i++) {
    bulkOps.push({
        insertOne: {
            document: { app: Math.floor(Math.random() * 10) + 1, host: Math.floor(Math.random() * 10) + 1, guest: Math.floor(Math.random() * 10) + 1 }
        }
    });

    // Insert in batches of 1000 documents to avoid overwhelming the server
    if (i % 1000 === 0 && i !== 0) {
        db.app.bulkWrite(bulkOps);
        bulkOps = [];
    }
}

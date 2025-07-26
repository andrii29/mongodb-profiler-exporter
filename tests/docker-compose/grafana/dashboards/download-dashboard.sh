#!/bin/bash

# Configuration variables
DASHBOARD_ID="20387"
DASHBOARD_REVISION="7"
DOWNLOAD_FOLDER="grafana/dashboards"
DASHBOARD_FILE="mongodb-profiler-dashboard.json"

# Download dashboard from Grafana.com
echo "Downloading MongoDB Profiler dashboard (ID: ${DASHBOARD_ID}, revision: ${DASHBOARD_REVISION})..."

curl -s "https://grafana.com/api/dashboards/${DASHBOARD_ID}/revisions/${DASHBOARD_REVISION}/download" \
  -H "Accept: application/json" \
  -o "${DOWNLOAD_FOLDER}/${DASHBOARD_FILE}"

if [ $? -eq 0 ]; then
  echo "Dashboard downloaded successfully to ${DOWNLOAD_FOLDER}/${DASHBOARD_FILE}"

  # Replace ${DS_PROMETHEUS} with Prometheus in the downloaded dashboard
  echo "Replacing \${DS_PROMETHEUS} with Prometheus..."
  sed -i 's/\${DS_PROMETHEUS}/Prometheus/g' "${DOWNLOAD_FOLDER}/${DASHBOARD_FILE}"

  if [ $? -eq 0 ]; then
    echo "Successfully replaced \${DS_PROMETHEUS} with Prometheus"
  else
    echo "Warning: Failed to replace \${DS_PROMETHEUS} in dashboard"
  fi
else
  echo "Failed to download dashboard"
  exit 1
fi

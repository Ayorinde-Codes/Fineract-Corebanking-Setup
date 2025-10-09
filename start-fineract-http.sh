#!/bin/bash

# This script starts Fineract on HTTP port 8080 for direct API access
# The HTTPS instance on port 8443 will continue to run for the Angular frontend

echo "Starting Fineract on HTTP port 8080 for direct API access..."
echo "The HTTPS instance on port 8443 will continue to run for the Angular frontend"

cd fineract

# Set environment variables for HTTP configuration
export FINERACT_SERVER_PORT=8080
export FINERACT_SERVER_SSL_ENABLED=false

# Start the backend with HTTP configuration
./gradlew bootRun

echo "Fineract HTTP server started on http://localhost:8080/fineract-provider"
echo "API endpoints available at: http://localhost:8080/fineract-provider/api/v1/" 
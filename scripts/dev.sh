#!/bin/bash

# Change to the project root directory (where package.json is)
cd "$(dirname "$0")/.." || exit 1

# Start PostgreSQL in the background
echo "Starting PostgreSQL..."
docker compose --env-file .env -f ./docker/docker-compose.yml up -d

# Wait for PostgreSQL to be ready
./docker/wait-for-postgres.sh
if [ $? -ne 0 ]; then
    echo "Failed to connect to PostgreSQL. Exiting..."
    docker compose --env-file .env -f ./docker/docker-compose.yml down
    exit 1
fi

# Load environment variables
source .env

# Export environment variables needed for Zero cache
export ZERO_UPSTREAM_DB
export ZERO_AUTH_SECRET
export ZERO_REPLICA_FILE

# Start the UI and Zero cache concurrently
echo "Starting UI and Zero cache..."
concurrently \
    --names "UI,ZERO" \
    --prefix-colors "cyan,magenta" \
    --kill-others \
    "bun run dev:ui" \
    "bun run dev:zero-cache"

# Cleanup on exit
echo "Shutting down..."
docker compose --env-file .env -f ./docker/docker-compose.yml down 
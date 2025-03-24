#!/bin/bash

echo "Waiting for PostgreSQL to be ready..."

# Maximum number of attempts
max_attempts=30
counter=0

while [ $counter -lt $max_attempts ]; do
    # Try to connect to PostgreSQL
    if docker compose --env-file .env -f ./docker/docker-compose.yml exec -T zstart_postgres pg_isready -U user -d postgres; then
        echo "PostgreSQL is ready!"
        exit 0
    fi
    
    # Print attempt number
    echo "Attempt $((counter + 1))/$max_attempts: PostgreSQL is not ready yet... waiting"
    counter=$((counter + 1))
    sleep 2
done

echo "Failed to connect to PostgreSQL after $max_attempts attempts"
exit 1 
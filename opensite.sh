#!/bin/bash

# Try different ports starting from 8000
port=8000
max_attempts=10
attempt=0

while [ $attempt -lt $max_attempts ]; do
    echo "Trying to start server on port $port..."
    
    # Check if the port is already in use
    if nc -z localhost $port 2>/dev/null; then
        echo "Port $port is already in use, trying next port..."
        port=$((port + 1))
        attempt=$((attempt + 1))
        continue
    fi
    
    # Start the HTTP server in the background
    python -m http.server $port &
    server_pid=$!
    
    # Wait a moment for server to start
    sleep 1
    
    # Check if server started successfully
    if kill -0 $server_pid 2>/dev/null; then
        echo "Server started successfully on port $port"
        echo "Opening in browser..."
        open "http://localhost:$port"
        
        # Keep the script running until user presses Ctrl+C
        echo "Press Ctrl+C to stop the server"
        wait $server_pid
        exit 0
    else
        echo "Failed to start server on port $port"
        port=$((port + 1))
        attempt=$((attempt + 1))
    fi
done

echo "Failed to start server after $max_attempts attempts"
exit 1 
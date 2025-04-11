#!/bin/bash

# Array of ports to try
ports=(3000 8080 8000 5000 4000)

for port in "${ports[@]}"; do
    echo "Trying to start server on port $port..."
    python3 -m http.server $port 2>/dev/null || python -m http.server $port 2>/dev/null
    
    # If command succeeded, we're done
    if [ $? -eq 0 ]; then
        echo "Server started successfully on port $port"
        echo "Visit http://localhost:$port in your browser"
        echo "Press Ctrl+C to stop the server"
        break
    else
        echo "Port $port is in use, trying next port..."
    fi
done

echo "Failed to start server on any port. Try opening index.html directly in your browser."
echo "You can do this by running: open index.html" 
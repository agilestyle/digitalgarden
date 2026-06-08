#!/bin/bash

PORT=8080
PID_FILE=".server.pid"

start() {
  if [ -f "$PID_FILE" ] && kill -0 "$(cat $PID_FILE)" 2>/dev/null; then
    echo "Server already running (PID $(cat $PID_FILE)) at http://localhost:$PORT"
    return
  fi
  echo "Starting Quartz server at http://localhost:$PORT ..."
  npx quartz build --serve --port $PORT &
  echo $! > "$PID_FILE"
  echo "Server started (PID $!) — stop with: ./server.sh stop"
}

stop() {
  if [ -f "$PID_FILE" ]; then
    PID=$(cat "$PID_FILE")
    kill "$PID" 2>/dev/null && echo "Server stopped (PID $PID)" || echo "Process not found"
    rm -f "$PID_FILE"
  else
    # Fallback: kill anything on the port
    lsof -ti :$PORT | xargs kill -9 2>/dev/null && echo "Server on port $PORT stopped" || echo "No server running"
  fi
}

case "$1" in
  start) start ;;
  stop)  stop  ;;
  restart) stop; sleep 1; start ;;
  *)
    echo "Usage: ./server.sh [start|stop|restart]"
    ;;
esac

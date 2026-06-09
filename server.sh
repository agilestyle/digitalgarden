#!/bin/bash

PORT=8080
PID_FILE=".server.pid"

BASE_DIR="/digitalgarden"

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

prod() {
  if [ -f "$PID_FILE" ] && kill -0 "$(cat $PID_FILE)" 2>/dev/null; then
    echo "A server is already running (PID $(cat $PID_FILE)). Run ./server.sh stop first."
    exit 1
  fi
  echo "→ Re-installing plugins (mirrors CI step) ..."
  npx quartz plugin install
  echo "→ Starting production-replica server at http://localhost:$PORT$BASE_DIR ..."
  npx quartz build --serve --port $PORT --baseDir $BASE_DIR &
  echo $! > "$PID_FILE"
  echo "Server started (PID $!) — stop with: ./server.sh stop"
  echo "Open: http://localhost:$PORT$BASE_DIR"
}

case "$1" in
  start)   start ;;
  stop)    stop  ;;
  restart) stop; sleep 1; start ;;
  prod)    prod  ;;
  *)
    echo "Usage: ./server.sh [start|stop|restart|prod]"
    echo ""
    echo "  start    — dev server with live reload (http://localhost:$PORT)"
    echo "  stop     — stop whichever server is running"
    echo "  restart  — stop + start"
    echo "  prod     — reinstall plugins + serve with production base path"
    echo "             (http://localhost:$PORT$BASE_DIR) — mirrors the CI deploy"
    ;;
esac

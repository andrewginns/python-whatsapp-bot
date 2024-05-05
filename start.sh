#!/bin/sh

# Load NGROK_AUTH_TOKEN from .env file
export $(grep '^NGROK_AUTH_TOKEN=' stack.env | xargs)
ngrok config add-authtoken ${NGROK_AUTH_TOKEN}

# Start ngrok in the background and redirect output to ngrok.out
export $(grep '^NGROK_DOMAIN=' stack.env | xargs)
ngrok http 8500 --domain=${NGROK_DOMAIN} > ngrok.out 2>&1 &

# Run the python flask server
python run.py
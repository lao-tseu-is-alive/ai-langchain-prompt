#!/bin/bash
ENV_FILENAME='.env'
if [ -f $ENV_FILENAME ]; then
  set -a
    # shellcheck disable=SC1090
    source <(sed -e '/^#/d;/^\s*$/d' -e "s/'/'\\\''/g" -e "s/=\(.*\)/='\1'/g" $ENV_FILENAME )
    echo "Checking if your XAI_API_KEY env is ok... XAI_API_KEY:${XAI_API_KEY}"
    curl -s https://api.x.ai/v1/chat/completions \
      -H "Content-Type: application/json" \
      -H "Authorization: Bearer $XAI_API_KEY" \
  -d '{
        "messages": [
          {
            "role": "system",
            "content": "You are Grok, a chatbot inspired by the Hitchhikers Guide to the Galaxy."
          },
          {
            "role": "user",
            "content": "What is the meaning of life, the universe, and everything?"
          }
        ],
        "model": "grok-beta",
        "stream": false,
        "temperature": 0
      }' |jq
    set +a
    echo "XAI_API_KEY is ok."
else
  echo "## 💥💥 your env file : ${ENV_FILENAME} was not found"
  exit 1
fi

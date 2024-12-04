#!/bin/bash
ENV_FILENAME='.env'
if [ -f $ENV_FILENAME ]; then
  set -a
    # shellcheck disable=SC1090
    source <(sed -e '/^#/d;/^\s*$/d' -e "s/'/'\\\''/g" -e "s/=\(.*\)/='\1'/g" $ENV_FILENAME )
    echo "Checking if your GEMINI_API_KEY env is ok... GEMINI_API_KEY:${GEMINI_API_KEY}"
      curl -s "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=${GEMINI_API_KEY}" \
    -H 'Content-Type: application/json' \
    -X POST \
    -d '{
      "contents": [{
        "parts":[{"text": "Write a short joke about a magic AI bot."}]
        }]
       }'|jq
    set +a
    echo "YOUR GEMINI_API_KEY is ok."
else
  echo "## 💥💥 your env file : ${ENV_FILENAME} was not found"
  exit 1
fi

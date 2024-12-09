#!/bin/bash
ENV_FILENAME='.env'
if [ -f $ENV_FILENAME ]; then
  set -a
    # shellcheck disable=SC1090
    source <(sed -e '/^#/d;/^\s*$/d' -e "s/'/'\\\''/g" -e "s/=\(.*\)/='\1'/g" $ENV_FILENAME )
    echo "Checking if your NVIDIA_API_KEY env is ok... NVIDIA_API_KEY:${NVIDIA_API_KEY}"
    curl -s "https://integrate.api.nvidia.com/v1/chat/completions" \
    -H 'Content-Type: application/json' \
    -H "Authorization: Bearer ${NVIDIA_API_KEY}" \
    -X POST \
    -d '{
    "model": "mistralai/mistral-7b-instruct-v0.3",
    "messages": [{"role":"user","content":"Write a short joke about a magic AI bot."}],
    "temperature": 0.2,
    "top_p": 0.7,
    "max_tokens": 1024,
    "stream": true
  }'|jq
    set +a
    echo "YOUR NVIDIA_API_KEY is ok."
else
  echo "## 💥💥 your env file : ${ENV_FILENAME} was not found"
  exit 1
fi

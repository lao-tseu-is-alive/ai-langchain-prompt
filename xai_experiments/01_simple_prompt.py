import os
from langchain_xai import ChatXAI

XAI_API_KEY = os.getenv("XAI_API_KEY")
if XAI_API_KEY is None:
    exit("XAI_API_KEY ENV variable not found")


llm = ChatXAI(
    model="grok-beta",
    temperature=0,
    max_tokens=None,
    max_retries=2,
    api_key=XAI_API_KEY,
    # api_key="...",
    # other params...
)
messages = [
    (
        "system",
        "You are a helpful translator. Translate the user sentence to French.",
    ),
    ("human", "I love programming."),
]
response = llm.invoke(messages)
print(response.content)
print("Usage metadata:")
print(response.usage_metadata)
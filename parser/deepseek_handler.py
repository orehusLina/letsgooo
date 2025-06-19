import os
import requests
import json
from dotenv import load_dotenv

load_dotenv()

DEEPSEEK_API_URL = "https://api.deepseek.com/v1/chat/completions"
DEEPSEEK_API_KEY = os.getenv("DEEPSEEK_API_KEY")

HEADERS = {
    "Authorization": f"Bearer {DEEPSEEK_API_KEY}",
    "Content-Type": "application/json"
}

def build_prompt(message_text: str) -> str:
    return f"""
Ты — ассистент, помогающий анализировать посты из Telegram-каналов.
Пост может содержать описание мероприятия, а может быть просто новостью или объявлением.

Если это действительно анонс мероприятия, выдели из текста:
- название (title)
- дату (date, формат YYYY-MM-DD)
- время (time, формат HH:MM, если указано)
- место проведения (location)
- тип мероприятия (type), например: лекция, концерт, митап, выставка и т.д.
- краткое описание (description)

Если в посте **нет информации о мероприятии**, верни:
{{ "is_event": false }}

Если это мероприятие — верни такой JSON:
{{
  "is_event": true,
  "title": "...",
  "date": "...",
  "time": "...",
  "location": "...",
  "type": "...",
  "description": "..."
}}

Вот сам текст поста:
\"\"\"
{message_text}
\"\"\"
"""

def extract_event_from_text(message_text: str) -> dict | None:
    prompt = build_prompt(message_text)

    payload = {
        "model": "deepseek-chat",
        "messages": [
            {"role": "user", "content": prompt}
        ],
        "temperature": 0.3
    }

    try:
        response = requests.post(DEEPSEEK_API_URL, headers=HEADERS, json=payload)
        response.raise_for_status()
        full_response = response.json()
        content = full_response['choices'][0]['message']['content']
        print("Ответ модели:\n", content)

        # чистим от ```json ... ```
        import re
        cleaned = re.sub(r"```json\s*", "", content)
        cleaned = re.sub(r"\s*```", "", cleaned)
        cleaned = cleaned.strip()

        data = json.loads(cleaned)

        if data.get("is_event"):
            return data
        else:
            return None

    except Exception as e:
        print("⚠️ Ошибка при разборе JSON:", e)
        return None

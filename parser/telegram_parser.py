import os
from telethon.sync import TelegramClient
from dotenv import load_dotenv
import json

from deepseek_handler import extract_event_from_text as extract_event_from_text

load_dotenv()

api_id = int(os.getenv("API_ID"))
api_hash = os.getenv("API_HASH")

client = TelegramClient('session_aggregator', api_id, api_hash)

channels = [
    'https://t.me/citysaratov',
    'https://t.me/saratov_kudago',
]

async def main():
    await client.start()
    events = []

    for channel in channels:
        async for message in client.iter_messages(channel, limit=10):
            if message.text:
                print(f"\n📥 Обработка поста:\n{message.text[:100]}...\n")
                parsed = extract_event_from_text(message.text)
                if parsed:
                    events.append(parsed)  # Удалили json.loads
                    print("✅ Успешно добавлено")

    # сохраняем в файл
    with open("parsed_events.json", "w", encoding="utf-8") as f:
        json.dump(events, f, indent=2, ensure_ascii=False)

    print(f"\n🎉 Сохранено {len(events)} событий в parsed_events.json")

if __name__ == "__main__":
    with client:
        client.loop.run_until_complete(main())

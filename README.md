# Lexiloop — a daily loop of words

Improve your vocabulary with a **daily word tailored to your mood**. Generate a clean definition card, keep a streak, compare with friends, and (on the roadmap) see translations. This repo contains the product brief, research, API sketch, seed data, and docs to help you ship an MVP quickly.

## ✨ Core features (MVP)
- **Daily Word by Mood:** Pick an emoji-like mood (calm, focused, ambitious, playful, reflective) → get a word + concise definition aligned to that mood.
- **Definition Card Generator:** One-tap export to a shareable image (feed/story sizes).
- **Gamified Progress:** Streak, XP, lightweight scorecard (word difficulty × retention).
- **Friends Feed:** Add friends and see each other's word cards (private by default).
- **Offline-first cache:** Yesterday’s word/definitions cached for quick loads.

## 🗺️ Roadmap
- Translations (Google Translate API)
- Review modes (quizzes, recap)
- Adaptive “mood model” (learns taste over time)
- Collections (CSV/Anki export)
- Voice (TTS + practice)
- Notifications

## 🏗️ Architecture (suggested)
Frontend: React/React Native • Backend: Node.js (Express/Fastify) or Python (FastAPI) • DB: Postgres • Cache: Redis • Auth: JWT/OAuth • Storage: S3/GCS • Jobs: BullMQ/Celery

```
Client (Web/Native)
   │
   ├── Auth (JWT/OAuth)
   │
   └── API
        ├── /words     → mood→word, definitions, examples
        ├── /cards     → render & fetch image cards
        ├── /scores    → streak, XP, stats
        ├── /social    → friends, feed, reactions
        └── /translate → proxy to Google Translate (v2)
```

## 🔑 API sketch
See [`api/openapi.yaml`](api/openapi.yaml) for a minimal OpenAPI stub you can extend.

## 🧠 Research & Docs
- [`research.md`](research.md) — background on corpora, difficulty, pedagogy
- [`roadmap.md`](roadmap.md) — phases and issues
- [`docs/lexiloop_full_app.pdf`](docs/lexiloop_full_app.pdf) — one-pager for the repo

## 🗃️ Seed data
Sample words live in [`data/seed_words.csv`](data/seed_words.csv). Replace with your own dataset (respect licenses).

## ⚙️ Local dev (example)
```bash
# backend
pnpm i
pnpm dev

# frontend
cd app && pnpm i && pnpm start
```

Env vars (see `.env.example`):
- `DATABASE_URL`, `JWT_SECRET`, `STORAGE_BUCKET`
- (v2) `GOOGLE_PROJECT_ID`, `GOOGLE_TRANSLATE_API_KEY`

## 🔒 Privacy & Safety
Private by default. Provide data export/delete. Rate-limit social actions; add blocks/reporting.

## 🤝 Contributing
Please read [`CONTRIBUTING.md`](CONTRIBUTING.md) and our [`CODE_OF_CONDUCT.md`](CODE_OF_CONDUCT.md). Security issues? See [`SECURITY.md`](SECURITY.md).

## 📄 License
Code is under the **Lexiloop Non‑Commercial License v1.0** (see `LICENSE`). Commercial use requires permission.

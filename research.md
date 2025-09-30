# Research: Lexiloop

## 🎯 Purpose
Lexiloop improves vocabulary via a **gamified daily loop**, tailoring words to mood. This document outlines: sources, difficulty calibration, mood mapping, pedagogy, and research directions.

## 📚 Word sourcing & difficulty
- **Corpora:** COCA, Google Ngrams, OpenSubtitles.
- **Lexical DBs/APIs:** WordNet, Wiktionary, Wordnik.
- **Difficulty:** CEFR bands, Zipf frequency, abstractness & morphology.

## 😊 Mood→word mapping
1) Choose categorical moods (calm, focused, ambitious, playful, reflective).  
2) Weight filters across difficulty, domain, tone, semantic tags.  
3) Score = rarity × semantic match × personal preference; sample from top candidates.

**Semantic tags:** derive with embeddings (spaCy/HuggingFace).  
**Examples:**  
- *Calm* → nature/wellbeing; soft phonotactics.  
- *Ambitious* → rhetoric/leadership; elevated tone.

## 🧠 Educational psychology
- **Spaced repetition** (Ebbinghaus): combats forgetting.  
- **Gamification** (SDT): autonomy, competence, relatedness.  
- **Flow:** adaptive difficulty prevents boredom/overwhelm.  
- **Dual coding:** word cards (visual+text) aid recall.

## 🖼️ Word card generation
- Minimal typographic layout; high contrast; accessible sizes.  
- Render via HTML→PNG (Puppeteer) or node-canvas.  
- Two presets: 1080×1080 and 1080×1920.

## 🌍 Future research
- Translation quality across CEFR levels.  
- Pronunciation (TTS & phoneme scoring).  
- Semantic clustering (“loops”).  
- Cultural adaptation.  
- Privacy, GDPR/CCPA compliance.

## 🔎 References
Nation (2013); Schmitt (2010); Ebbinghaus (1913); Deci & Ryan (1985); Paivio (1990).

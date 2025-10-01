-- db/schema.sql
-- Minimal Postgres schema for Lexiloop MVP

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Users (minimal for seeding words; extend later)
CREATE TABLE IF NOT EXISTS users (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  handle TEXT UNIQUE,
  email TEXT UNIQUE,
  locale TEXT,
  timezone TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Words catalog
CREATE TABLE IF NOT EXISTS words (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  headword TEXT NOT NULL UNIQUE,
  pos TEXT,
  definition TEXT NOT NULL,
  example TEXT,
  difficulty NUMERIC,            -- 0.0 - 1.0
  frequency TEXT,                -- e.g., high|medium|low
  domain TEXT,                   -- e.g., nature|rhetoric|philosophy
  tags TEXT[] DEFAULT '{}',      -- e.g., {soothing,neutral}
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Assignments: daily word per user
CREATE TABLE IF NOT EXISTS assignments (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  word_id UUID REFERENCES words(id) ON DELETE CASCADE,
  date DATE NOT NULL,
  mood TEXT,
  accepted_at TIMESTAMPTZ,
  mastered BOOLEAN DEFAULT false,
  UNIQUE (user_id, date)
);

-- Scores / streaks
CREATE TABLE IF NOT EXISTS scores (
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  date DATE NOT NULL,
  xp INT DEFAULT 0,
  streak_count INT DEFAULT 0,
  PRIMARY KEY (user_id, date)
);

-- Cards (rendered images)
CREATE TABLE IF NOT EXISTS cards (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  word_id UUID REFERENCES words(id) ON DELETE CASCADE,
  url TEXT NOT NULL,
  width INT,
  height INT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

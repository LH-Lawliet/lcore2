CREATE TABLE IF NOT EXISTS users(
    id SERIAL PRIMARY KEY,
    steam TEXT UNIQUE,
    license TEXT UNIQUE,
    xbl TEXT UNIQUE,
    live TEXT UNIQUE,
    discord TEXT UNIQUE,
    license2 TEXT UNIQUE,
    ip TEXT NOT NULL,
    banned TIMESTAMP,
    ban_reason TEXT,
    last_connection TIMESTAMP,
    admin_level BIGINT default 0
);

UPDATE lcoreINFO SET sqlVersion=1;
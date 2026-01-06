-- 0001_schema.sql
-- Application schema

CREATE SCHEMA IF NOT EXISTS app;

-- Ensure future sessions can find app objects easily when running migrations.
SET search_path TO app, public;

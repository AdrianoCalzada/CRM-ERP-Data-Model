-- 0009_audit.sql
SET search_path TO app, public;

-- AuditLog
CREATE TABLE IF NOT EXISTS audit_log (
  log_id bigserial PRIMARY KEY,
  company_id uuid REFERENCES company(company_id),
  user_id uuid REFERENCES "user"(user_id),

  action text NOT NULL,
  entity_type text,
  entity_id uuid,

  old_values jsonb,
  new_values jsonb,

  ip_address text,
  user_agent text,

  "timestamp" timestamptz NOT NULL DEFAULT now()
);

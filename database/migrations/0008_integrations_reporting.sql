-- 0008_integrations_reporting.sql
SET search_path TO app, public;

-- Integration
CREATE TABLE IF NOT EXISTS integration (
  integration_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id uuid NOT NULL REFERENCES company(company_id),

  service_name text NOT NULL,
  api_key text,
  config_data jsonb,

  is_active boolean NOT NULL DEFAULT true,
  last_sync_at timestamptz,

  created_at timestamptz NOT NULL DEFAULT now()
);

-- WebhookEndpoint
CREATE TABLE IF NOT EXISTS webhook_endpoint (
  endpoint_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id uuid NOT NULL REFERENCES company(company_id),

  url text NOT NULL,
  secret text,
  is_active boolean NOT NULL DEFAULT true,

  created_at timestamptz NOT NULL DEFAULT now()
);

-- WebhookEventType
CREATE TABLE IF NOT EXISTS webhook_event_type (
  event_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  endpoint_id uuid NOT NULL REFERENCES webhook_endpoint(endpoint_id),

  event_type text NOT NULL,
  created_at timestamptz NOT NULL DEFAULT now(),

  CONSTRAINT webhook_event_type_unique UNIQUE (endpoint_id, event_type)
);

-- WebhookDelivery
CREATE TABLE IF NOT EXISTS webhook_delivery (
  delivery_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  endpoint_id uuid NOT NULL REFERENCES webhook_endpoint(endpoint_id),

  event_name text,
  payload jsonb,
  attempt integer,
  status text,
  error text,
  next_retry_at timestamptz,
  idempotency_key text,

  created_at timestamptz NOT NULL DEFAULT now()
);

-- JobQueue
CREATE TABLE IF NOT EXISTS job_queue (
  job_id bigserial PRIMARY KEY,

  type text NOT NULL,
  payload jsonb,
  run_at timestamptz,
  attempts integer,
  status text,
  last_error text,

  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);

-- Notification
CREATE TABLE IF NOT EXISTS notification (
  notification_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id uuid NOT NULL REFERENCES company(company_id),
  user_id uuid NOT NULL REFERENCES "user"(user_id),

  title text NOT NULL,
  message text,
  type text,
  is_read boolean NOT NULL DEFAULT false,
  action_url text,

  created_at timestamptz NOT NULL DEFAULT now()
);

-- ReportSchedule
CREATE TABLE IF NOT EXISTS report_schedule (
  schedule_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id uuid NOT NULL REFERENCES company(company_id),

  report_type text NOT NULL,
  frequency text,
  parameters jsonb,
  last_run_at timestamptz,
  next_run_at timestamptz,
  is_active boolean NOT NULL DEFAULT true,

  created_at timestamptz NOT NULL DEFAULT now()
);

-- KPI
CREATE TABLE IF NOT EXISTS kpi (
  kpi_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id uuid NOT NULL REFERENCES company(company_id),

  name text NOT NULL,
  calculation_query text,
  target_value numeric,
  period text,

  updated_at timestamptz NOT NULL DEFAULT now(),

  CONSTRAINT kpi_company_name_unique UNIQUE (company_id, name)
);

-- EmailTemplate
CREATE TABLE IF NOT EXISTS email_template (
  template_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id uuid NOT NULL REFERENCES company(company_id),

  name text NOT NULL,
  subject text,
  body text,
  variables jsonb,
  is_active boolean NOT NULL DEFAULT true,

  created_at timestamptz NOT NULL DEFAULT now(),

  CONSTRAINT email_template_company_name_unique UNIQUE (company_id, name)
);

-- CompanyPhone
CREATE TABLE IF NOT EXISTS company_phone (
  phone_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id uuid NOT NULL REFERENCES company(company_id),

  phone_number text NOT NULL,
  created_at timestamptz NOT NULL DEFAULT now(),

  CONSTRAINT company_phone_unique UNIQUE (company_id, phone_number)
);

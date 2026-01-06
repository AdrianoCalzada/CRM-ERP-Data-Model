-- 0004_crm.sql
SET search_path TO app, public;

-- Contact
CREATE TABLE IF NOT EXISTS contact (
  contact_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id uuid NOT NULL REFERENCES company(company_id),

  type text,
  first_name text,
  last_name text,
  email text,
  phone text,
  company_name text,
  job_title text,
  department text,
  source text,
  status text,

  address_street text,
  address_city text,
  address_country text,

  notes text,

  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);

-- ContactTag
CREATE TABLE IF NOT EXISTS contact_tag (
  tag_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  contact_id uuid NOT NULL REFERENCES contact(contact_id),

  tag_name text NOT NULL,
  created_at timestamptz NOT NULL DEFAULT now(),

  CONSTRAINT contact_tag_unique UNIQUE (contact_id, tag_name)
);

-- Deal
CREATE TABLE IF NOT EXISTS deal (
  deal_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id uuid NOT NULL REFERENCES company(company_id),
  contact_id uuid NOT NULL REFERENCES contact(contact_id),
  owner_user_id uuid NOT NULL REFERENCES "user"(user_id),

  name text NOT NULL,
  description text,
  value numeric,
  stage text,
  probability numeric,
  expected_close_date date,
  actual_close_date date,
  status text,
  loss_reason text,

  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);

-- Activity
CREATE TABLE IF NOT EXISTS activity (
  activity_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id uuid NOT NULL REFERENCES company(company_id),
  user_id uuid REFERENCES "user"(user_id),
  contact_id uuid REFERENCES contact(contact_id),
  deal_id uuid REFERENCES deal(deal_id),

  type text,
  subject text,
  description text,
  content text,
  due_date date,
  completed_date date,
  status text,

  entity_type text,
  entity_id uuid,

  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);

-- CalendarEvent
CREATE TABLE IF NOT EXISTS calendar_event (
  event_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id uuid NOT NULL REFERENCES company(company_id),
  created_by uuid REFERENCES "user"(user_id),

  title text NOT NULL,
  description text,
  start_time timestamptz NOT NULL,
  end_time timestamptz NOT NULL,

  entity_type text,
  entity_id uuid,

  reminder_sent boolean NOT NULL DEFAULT false,
  status text,

  created_at timestamptz NOT NULL DEFAULT now()
);

-- Task
CREATE TABLE IF NOT EXISTS task (
  task_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id uuid NOT NULL REFERENCES company(company_id),
  assigned_to uuid REFERENCES "user"(user_id),

  title text NOT NULL,
  description text,
  due_date date,
  priority text,
  status text,

  entity_type text,
  entity_id uuid,

  completed_at timestamptz,

  created_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);

-- Document
CREATE TABLE IF NOT EXISTS document (
  document_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id uuid NOT NULL REFERENCES company(company_id),
  uploaded_by uuid REFERENCES "user"(user_id),

  entity_type text NOT NULL,
  entity_id uuid NOT NULL,

  document_type text,
  file_name text NOT NULL,
  file_path text NOT NULL,
  file_size integer,
  mime_type text,
  storage_provider text,
  bucket text,
  checksum text,
  version integer,

  uploaded_at timestamptz NOT NULL,
  expires_at timestamptz,
  deleted_at timestamptz
);

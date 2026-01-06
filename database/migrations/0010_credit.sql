-- 0010_credit.sql
SET search_path TO app, public;

-- ClientApplication
CREATE TABLE IF NOT EXISTS client_application (
  application_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id uuid NOT NULL REFERENCES company(company_id),
  contact_id uuid REFERENCES contact(contact_id),

  first_name text,
  last_name text,
  email text,
  phone text,

  cpf text,
  cnpj text,

  company_age integer,
  company_size text,
  segment text,
  revenue numeric,
  has_physical_location boolean,

  credit_purpose text,
  notes text,
  status text,
  converted_at timestamptz,

  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);

-- CreditAnalysis
CREATE TABLE IF NOT EXISTS credit_analysis (
  analysis_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id uuid NOT NULL REFERENCES company(company_id),
  client_application_id uuid NOT NULL REFERENCES client_application(application_id),
  analyst_user_id uuid REFERENCES "user"(user_id),

  risk_score numeric,
  approved_amount numeric,
  interest_rate numeric,
  justification text,
  status text,

  created_at timestamptz NOT NULL DEFAULT now()
);

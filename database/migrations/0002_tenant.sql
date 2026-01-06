-- 0002_tenant.sql
SET search_path TO app, public;

-- Company
CREATE TABLE IF NOT EXISTS company (
  company_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,

  address_street text,
  address_number text,
  address_postal_code text,
  address_neighborhood text,
  address_city text,
  address_state text,

  website text,

  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);

-- CompanySettings (1:1 with Company)
CREATE TABLE IF NOT EXISTS company_settings (
  company_id uuid PRIMARY KEY REFERENCES company(company_id),

  razao_social text,
  cnpj text,
  endereco text,
  telefone text,
  logo_ref text,

  default_currency text NOT NULL,

  theme_settings jsonb,
  security_settings jsonb,
  integration_settings jsonb,

  updated_at timestamptz NOT NULL DEFAULT now()
);

-- TenantSetting (key/value settings)
CREATE TABLE IF NOT EXISTS tenant_setting (
  setting_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id uuid NOT NULL REFERENCES company(company_id),

  setting_key text NOT NULL,
  setting_value text,
  data_type text,

  updated_at timestamptz NOT NULL DEFAULT now(),

  CONSTRAINT tenant_setting_company_key_unique UNIQUE (company_id, setting_key)
);

-- CompanyDomain
CREATE TABLE IF NOT EXISTS company_domain (
  domain_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id uuid NOT NULL REFERENCES company(company_id),

  domain_name text NOT NULL UNIQUE,
  is_primary boolean NOT NULL DEFAULT false,
  verified_at timestamptz,

  created_at timestamptz NOT NULL DEFAULT now()
);

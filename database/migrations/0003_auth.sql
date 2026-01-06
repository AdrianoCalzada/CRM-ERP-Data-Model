-- 0003_auth.sql
SET search_path TO app, public;

-- User
CREATE TABLE IF NOT EXISTS "user" (
  user_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id uuid NOT NULL REFERENCES company(company_id),

  email text NOT NULL UNIQUE,
  password_hash text NOT NULL,

  first_name text,
  last_name text,
  phone text,
  role text,
  avatar_url text,
  email_verified boolean NOT NULL DEFAULT false,
  is_active boolean NOT NULL DEFAULT true,
  last_login_at timestamptz,

  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);

-- Session
CREATE TABLE IF NOT EXISTS session (
  session_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL REFERENCES "user"(user_id),
  expires_at timestamptz NOT NULL,
  created_at timestamptz NOT NULL DEFAULT now()
);

-- UserRole
CREATE TABLE IF NOT EXISTS user_role (
  role_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id uuid NOT NULL REFERENCES company(company_id),

  name text NOT NULL,
  permissions jsonb,
  is_system_role boolean NOT NULL DEFAULT false,

  created_at timestamptz NOT NULL DEFAULT now(),

  CONSTRAINT user_role_company_name_unique UNIQUE (company_id, name)
);

-- Many-to-many: User <-> UserRole
CREATE TABLE IF NOT EXISTS user_user_role (
  user_id uuid NOT NULL REFERENCES "user"(user_id),
  role_id uuid NOT NULL REFERENCES user_role(role_id),
  created_at timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (user_id, role_id)
);

-- OAuthAccount
CREATE TABLE IF NOT EXISTS oauth_account (
  oauth_account_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL REFERENCES "user"(user_id),

  provider text NOT NULL,
  provider_user_id text NOT NULL,
  access_token text,
  refresh_token text,
  expires_at timestamptz,

  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),

  CONSTRAINT oauth_account_provider_unique UNIQUE (provider, provider_user_id)
);

-- TwoFactor
CREATE TABLE IF NOT EXISTS two_factor (
  two_factor_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL UNIQUE REFERENCES "user"(user_id),

  totp_secret text,
  enabled_at timestamptz,

  created_at timestamptz NOT NULL DEFAULT now()
);

-- BackupCode
CREATE TABLE IF NOT EXISTS backup_code (
  code_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  two_factor_id uuid NOT NULL REFERENCES two_factor(two_factor_id),

  code text NOT NULL UNIQUE,
  used_at timestamptz,

  created_at timestamptz NOT NULL DEFAULT now()
);

-- PasswordResetToken
CREATE TABLE IF NOT EXISTS password_reset_token (
  token_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL REFERENCES "user"(user_id),

  token text NOT NULL UNIQUE,
  expires_at timestamptz NOT NULL,
  used_at timestamptz,

  created_at timestamptz NOT NULL DEFAULT now()
);

-- EmailVerificationToken
CREATE TABLE IF NOT EXISTS email_verification_token (
  token_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL REFERENCES "user"(user_id),

  token text NOT NULL UNIQUE,
  expires_at timestamptz NOT NULL,
  used_at timestamptz,

  created_at timestamptz NOT NULL DEFAULT now()
);

-- 0006_plans_subscriptions.sql
SET search_path TO app, public;

-- Plan
CREATE TABLE IF NOT EXISTS plan (
  plan_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL UNIQUE,

  price_monthly numeric,
  price_yearly numeric,

  is_active boolean NOT NULL DEFAULT true,
  created_at timestamptz NOT NULL DEFAULT now()
);

-- Subscription
CREATE TABLE IF NOT EXISTS subscription (
  subscription_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id uuid NOT NULL REFERENCES company(company_id),
  plan_id uuid NOT NULL REFERENCES plan(plan_id),

  billing_cycle text,
  status text,
  start_date date,
  end_date date,
  next_billing_date date,

  stripe_subscription_id text UNIQUE,
  idempotency_key text,

  created_at timestamptz NOT NULL DEFAULT now()
);

-- PlanFeature
CREATE TABLE IF NOT EXISTS plan_feature (
  feature_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  plan_id uuid NOT NULL REFERENCES plan(plan_id),

  feature_name text NOT NULL,
  feature_value text,

  created_at timestamptz NOT NULL DEFAULT now(),

  CONSTRAINT plan_feature_unique UNIQUE (plan_id, feature_name)
);

-- PlanLimit
CREATE TABLE IF NOT EXISTS plan_limit (
  limit_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  plan_id uuid NOT NULL REFERENCES plan(plan_id),

  limit_name text NOT NULL,
  limit_value text NOT NULL,

  created_at timestamptz NOT NULL DEFAULT now(),

  CONSTRAINT plan_limit_unique UNIQUE (plan_id, limit_name)
);

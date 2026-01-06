-- 0007_finance.sql
SET search_path TO app, public;

-- CostCenter
CREATE TABLE IF NOT EXISTS cost_center (
  cost_center_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id uuid NOT NULL REFERENCES company(company_id),

  name text NOT NULL,
  description text,
  budget numeric,
  color text,
  is_active boolean NOT NULL DEFAULT true,

  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz,

  CONSTRAINT cost_center_company_name_unique UNIQUE (company_id, name)
);

-- RevenueCategory
CREATE TABLE IF NOT EXISTS revenue_category (
  category_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id uuid NOT NULL REFERENCES company(company_id),

  name text NOT NULL,
  description text,
  is_active boolean NOT NULL DEFAULT true,

  created_at timestamptz NOT NULL DEFAULT now(),

  CONSTRAINT revenue_category_company_name_unique UNIQUE (company_id, name)
);

-- ExpenseCategory
CREATE TABLE IF NOT EXISTS expense_category (
  category_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id uuid NOT NULL REFERENCES company(company_id),

  name text NOT NULL,
  description text,
  is_active boolean NOT NULL DEFAULT true,

  created_at timestamptz NOT NULL DEFAULT now(),

  CONSTRAINT expense_category_company_name_unique UNIQUE (company_id, name)
);

-- Revenue
CREATE TABLE IF NOT EXISTS revenue (
  revenue_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id uuid NOT NULL REFERENCES company(company_id),
  contact_id uuid REFERENCES contact(contact_id),
  invoice_id uuid REFERENCES invoice(invoice_id),
  cost_center_id uuid REFERENCES cost_center(cost_center_id),

  description text,
  amount numeric NOT NULL,
  revenue_date date NOT NULL,
  category text,

  created_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);

-- Expense
CREATE TABLE IF NOT EXISTS expense (
  expense_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id uuid NOT NULL REFERENCES company(company_id),
  cost_center_id uuid REFERENCES cost_center(cost_center_id),

  description text,
  category text,
  amount numeric NOT NULL,
  expense_date date NOT NULL,
  vendor text,
  payment_method text,
  status text,

  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);

-- BankAccount
CREATE TABLE IF NOT EXISTS bank_account (
  bank_account_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id uuid NOT NULL REFERENCES company(company_id),

  bank_name text NOT NULL,
  agency text,
  account_number text,
  account_type text,
  balance numeric,
  is_active boolean NOT NULL DEFAULT true,

  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);

-- BankStatementEntry
CREATE TABLE IF NOT EXISTS bank_statement_entry (
  entry_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  bank_account_id uuid NOT NULL REFERENCES bank_account(bank_account_id),

  transaction_date date NOT NULL,
  description text,
  amount numeric NOT NULL,
  transaction_type text,
  balance_after numeric,
  reference_number text,

  created_at timestamptz NOT NULL DEFAULT now()
);

-- Contract
CREATE TABLE IF NOT EXISTS contract (
  contract_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id uuid NOT NULL REFERENCES company(company_id),
  contact_id uuid NOT NULL REFERENCES contact(contact_id),

  total_value numeric NOT NULL,
  interest_rate numeric,
  installment_count integer,
  start_date date,
  end_date date,
  status text,

  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);

-- ContractInstallment
CREATE TABLE IF NOT EXISTS contract_installment (
  installment_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  contract_id uuid NOT NULL REFERENCES contract(contract_id),

  installment_number integer NOT NULL,
  due_date date NOT NULL,
  amount numeric NOT NULL,
  status text,
  paid_date date,
  late_fee numeric,

  created_at timestamptz NOT NULL DEFAULT now(),

  CONSTRAINT contract_installment_unique UNIQUE (contract_id, installment_number)
);

-- Payment
CREATE TABLE IF NOT EXISTS payment (
  payment_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id uuid NOT NULL REFERENCES company(company_id),
  contract_installment_id uuid REFERENCES contract_installment(installment_id),
  bank_account_id uuid REFERENCES bank_account(bank_account_id),

  amount numeric NOT NULL,
  payment_date date NOT NULL,
  payment_method text,
  reference_number text,
  status text,
  idempotency_key text,

  created_at timestamptz NOT NULL DEFAULT now()
);

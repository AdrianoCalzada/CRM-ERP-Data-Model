-- 0005_products_sales.sql
SET search_path TO app, public;

-- Product
CREATE TABLE IF NOT EXISTS product (
  product_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id uuid NOT NULL REFERENCES company(company_id),

  type text,
  name text NOT NULL,
  description text,
  sku text UNIQUE,
  category text,

  price numeric NOT NULL,
  cost numeric,
  tax_rate numeric,

  is_active boolean NOT NULL DEFAULT true,
  track_inventory boolean NOT NULL DEFAULT false,

  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);

-- Service
CREATE TABLE IF NOT EXISTS service (
  service_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id uuid NOT NULL REFERENCES company(company_id),

  name text NOT NULL,
  description text,

  price numeric NOT NULL,
  cost numeric,
  duration integer,
  category text,

  is_active boolean NOT NULL DEFAULT true,

  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);

-- Sale
CREATE TABLE IF NOT EXISTS sale (
  sale_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id uuid NOT NULL REFERENCES company(company_id),
  contact_id uuid NOT NULL REFERENCES contact(contact_id),

  total_amount numeric NOT NULL,
  sale_date date NOT NULL,
  status text,
  payment_terms text,

  created_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);

-- SaleItem
CREATE TABLE IF NOT EXISTS sale_item (
  sale_item_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  sale_id uuid NOT NULL REFERENCES sale(sale_id),
  product_id uuid REFERENCES product(product_id),
  service_id uuid REFERENCES service(service_id),

  quantity integer NOT NULL,
  unit_price numeric NOT NULL,
  total_amount numeric NOT NULL,

  created_at timestamptz NOT NULL DEFAULT now(),

  CONSTRAINT sale_item_product_or_service CHECK (
    (product_id IS NOT NULL AND service_id IS NULL)
    OR (product_id IS NULL AND service_id IS NOT NULL)
  )
);

-- InventoryMovement
CREATE TABLE IF NOT EXISTS inventory_movement (
  movement_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id uuid NOT NULL REFERENCES company(company_id),
  product_id uuid NOT NULL REFERENCES product(product_id),

  movement_type text,
  quantity integer NOT NULL,
  unit_cost numeric,
  reference_id uuid,
  notes text,

  created_at timestamptz NOT NULL DEFAULT now()
);

-- Invoice
CREATE TABLE IF NOT EXISTS invoice (
  invoice_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id uuid NOT NULL REFERENCES company(company_id),
  contact_id uuid NOT NULL REFERENCES contact(contact_id),

  invoice_number text UNIQUE,
  type text,
  status text,

  issue_date date NOT NULL,
  due_date date,
  paid_date date,

  subtotal numeric NOT NULL,
  tax_amount numeric,
  total_amount numeric NOT NULL,

  notes text,
  terms_and_conditions text,
  idempotency_key text,

  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);

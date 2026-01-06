# Database Migrations (PostgreSQL)

These files are the **source of truth** for the physical database schema.

## How to apply (pgAdmin)
Run the SQL files in **lexicographic order** (e.g., `0000_...` then `0001_...`).

Recommended first run order:
1. `0000_extensions.sql`
2. `0001_schema.sql`
3. `0002_tenant.sql`
4. `0003_auth.sql`
5. `0004_crm.sql`
6. `0005_products_sales.sql`
7. `0006_plans_subscriptions.sql`
8. `0007_finance.sql`
9. `0008_integrations_reporting.sql`
10. `0009_audit.sql`
11. `0010_credit.sql`
12. `0090_indexes.sql`

## Conventions
- All tables live in the `app` schema.
- UUID primary keys use `gen_random_uuid()` (requires `pgcrypto`).
- `updated_at` defaults to `now()` but should be maintained by the application (or later via triggers).

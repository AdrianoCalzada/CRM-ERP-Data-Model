# Business Requirements

## Vision
Provide a multi-tenant CRM + lightweight ERP platform for Brazilian SMBs integrating customer lifecycle, contracts, billing, cash flow, inventory, tasks, and reporting.

## Core Business Objectives
- Centralize client (Contact) lifecycle (lead → application → credit analysis → contract → invoicing → payment).
- Improve financial visibility (revenues, expenses, cost centers, cash position).
- Accelerate sales with Kanban pipeline and activity tracking.
- Reduce manual work via document management and scheduled reports.
- Support secure multi-company (tenant) isolation.
- Enable extensibility via webhooks and third‑party integrations (Google Calendar, future accounting).

## Problems to Solve
- Fragmented customer + financial data.
- Lack of consistent contract / installment tracking.
- Manual credit onboarding.
- Poor visibility of KPIs (MRR, churn, overdue installments, cash runway).
- No unified document store.
- Need role-based, auditable access.

## Primary Personas
- Admin (company owner) – configures tenant, billing, roles.
- Sales Rep – manages contacts, deals, tasks, activities.
- Credit Analyst – processes ClientApplications & CreditAnalysis.
- Finance User – manages invoices, payments, expenses, bank accounts.
- Operations – handles inventory and contracts.
- External Integrations – consume webhook events.

## MVP Functional Scope (Must-Have)
- Company registration & onboarding (create tenant, initial admin).
- User authentication (email/password) + roles (RBAC core).
- Contact management (CRUD, tagging, status).
- Deal pipeline (Kanban stages, probability, close dates).
- ClientApplication + CreditAnalysis workflow (basic statuses).
- Contract & Installments (generation, status tracking).
- Invoice issuance (manual creation, status lifecycle).
- Payments (record against installments; partial).
- Expenses + ExpenseCategory; Revenues + RevenueCategory.
- CostCenter allocation for revenue/expense.
- BankAccount + BankStatementEntry (manual input).
- Product & Service catalog (basic inventory movements).
- Tasks, Activities, CalendarEvents (CRUD, polymorphic link).
- Document upload (file metadata).
- Dashboard KPIs (pipeline count, overdue installments, total receivables, expense vs revenue trend).
- Basic reporting (export CSV/PDF: contacts, deals, invoices, expenses).
- AuditLog for high-risk actions.
- WebhookEndpoint + WebhookDelivery (events: contact.created, deal.updated, invoice.paid).

## Phase 2 (Should-Have / Nice-to-Have)
- Subscription management (plan upgrades, billing cycle sync).
- Unified FinancialTransaction ledger.
- Automated installment generation from contract templates.
- Google Calendar two-way sync.
- Advanced inventory (warehouses, reorder alerts).
- EmailTemplate system + notification preferences.
- KPI definition UI (custom formulas).
- JobQueue orchestration (scheduled exports / async tasks).
- TwoFactor + OAuthAccount (Google sign-in).
- Integration accounting export (SPED / simplified).
- Webhook retry/backoff dashboard.
- Exchange rates multi-currency support.

## Out of Scope (Initial Release)
- Automated tax calculation engine.
- Real-time payment gateway integration.
- Full payroll / HR.
- Advanced BI tooling (cube designer).
- Mobile native app.

## Non-Functional Requirements
- Multi-tenant isolation (company_id scoping + RLS).
- Security: hashed passwords (Argon2/Bcrypt), audit logging, least privilege.
- Availability target: 99.5% MVP.
- Performance: main list endpoints < 300ms p95 with ≤10k records per tenant.
- Scalability: horizontal partition by company_id.
- Data retention: soft delete + 30‑day restore.
- File storage: checksum verification, max file size configurable.

## Data & Compliance
- Unique constraints: user email, product SKU, invoice number (per company).
- PII: encrypt sensitive fields (cpf/cnpj optional).
- Access logs retained ≥180 days.
- GDPR-like export (contact data) via scheduled job.

## Integration Requirements
- Webhooks: signed (HMAC secret), retries (exponential, max 6).
- Google Calendar: OAuth, store refresh_token.
- Future accounting: CSV export schema stable versioned.

## Security & Roles (Baseline)
- Roles: admin, sales, finance, analyst, ops, read_only.
- Permission groups: contacts, deals, applications, credit, contracts, invoices, payments, finance (expenses/revenues), inventory, tasks, documents, settings.
- Admin only: company settings, subscription, roles, integrations.

## Reporting & KPIs (MVP)
- Pipeline summary (deals by stage).
- Overdue installments count & total.
- Monthly revenue vs expense.
- Top 10 contacts by contract value.
- Export endpoints (async if >5k rows).

## Success Metrics
- Time to onboard (company + first contact) < 5 minutes.
- Reduce manual spreadsheet use (proxy: >70% contracts recorded).
- Payment reconciliation accuracy ≥ 99%.
- User daily active ratio (DAU/WAU) target ≥ 35% after month 2.
- Webhook delivery success ≥ 97% first attempt.

## Critical Domain Rules
- A Contact can have multiple Deals, Contracts, Invoices.
- ContractInstallment status derived from payments (paid when sum >= amount).
- Invoice becomes "paid" when linked payments reach total_amount.
- Deleting Contact restricted if active Contract or unpaid Invoice.
- Only one active Subscription per Company.
- Document must reference a valid host entity (entity_type/entity_id pair).

## Risk List (Monitored)
- Scope creep from unified ledger early (mitigate: phase 2).
- Data consistency between installments and revenues.
- High cardinality polymorphic tables (index strategy).
- Large file storage cost (enforce quotas).
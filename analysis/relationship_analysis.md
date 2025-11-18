# Relationships & Cardinalities

## Conventions
- Notation: A 1—M B means “A has many B; B belongs to A”
- All tenant data is scoped by company_id; foreign keys include company_id where applicable

## Multitenancy
- Company 1—M User
  - Reason: many users per tenant
- Company 1—1 CompanySettings
  - Reason: single settings record per tenant
- Company 1—M TenantSetting
  - Reason: key/value overrides per tenant
- Company 1—M CompanyDomain
  - Reason: tenants can have multiple domains (one primary)

## Identity, Auth, Security
- User 1—M Session
  - Reason: multiple concurrent logins/devices
- User 1—M OAuthAccount
  - Reason: users can link multiple providers
- User 0—1 TwoFactor
  - Reason: optional TOTP; single secret per user
- User 1—M PasswordResetToken; User 1—M EmailVerificationToken
  - Reason: multiple requests over time
- User M—N UserRole via UserPermission (user_id, role_id)
  - Reason: users can be in multiple roles; role-based access

## CRM
- Company 1—M Contact
  - Reason: many contacts per tenant
- Contact 1—M Deal
  - Reason: a contact can have multiple opportunities
- User 1—M Deal (owner_user_id)
  - Reason: pipeline ownership/assignment
- Contact 1—M Activity; Deal 1—M Activity; User 1—M Activity (actor)
  - Reason: timeline across entities and actors
- Any Entity 1—M Document (polymorphic: entity_type, entity_id)
  - Reason: multiple files per entity (contracts, KYC, etc.)
- Any Entity 1—M CalendarEvent (polymorphic)
  - Reason: many events/appointments per entity
- Any Entity 1—M Task (polymorphic); User 1—M Task (assigned_to)
  - Reason: action items per entity and per assignee
- Contact 1—M Invoice
  - Reason: many invoices per customer

## Sales, Products, Inventory
- Company 1—M Product; Company 1—M Service
  - Reason: tenant-specific catalogs
- Sale 1—M SaleItem
  - Reason: order lines
- Contact 1—M Sale
  - Reason: many orders per customer
- Product 1—M SaleItem; Service 1—M SaleItem
  - Reason: lines reference either type
  - Constraint: exactly one of (product_id, service_id) is non-null
- Product 1—M InventoryMovement
  - Reason: stock changes over time

## Contracts, Billing, Payments
- Contact 1—M Contract
  - Reason: a customer can have multiple agreements
- Contract 1—M ContractInstallment
  - Reason: schedule split into parcels
- ContractInstallment 0—M Payment
  - Reason: partial/multiple payments per installment
- BankAccount 1—M Payment
  - Reason: payments are settled into an account
- Plan 1—M Subscription; Company 1—M Subscription
  - Reason: plan has many subscribers; a company can have a history of subscriptions (enforce max 1 active per company)

## Invoicing & Revenue
- Contact 1—M Invoice
  - Reason: billing per customer
- Invoice 0—M Revenue
  - Reason: optional mapping; revenues can be split/allocated across categories
- RevenueCategory 1—M Revenue
  - Reason: classification for reporting
- CostCenter 1—M Revenue
  - Reason: allocation by cost center

## Expenses & Cost Centers
- ExpenseCategory 1—M Expense
  - Reason: classification for reporting
- CostCenter 1—M Expense
  - Reason: budgeting and accountability

Banking & Cash Flow
- Company 1—M BankAccount
  - Reason: multiple accounts per tenant
- BankAccount 1—M BankStatementEntry
  - Reason: entries per account over time

## Integrations, Webhooks, Jobs, Notifications
- Company 1—M Integration
  - Reason: multiple third-party connections
- Company 1—M WebhookEndpoint; WebhookEndpoint 1—M WebhookDelivery
  - Reason: many endpoints and delivery attempts
- JobQueue M—0..1 Company
  - Reason: jobs can be tenant-scoped or system-wide (nullable company_id in payload/config)
- Company 1—M Notification; User 1—M Notification
  - Reason: notify users within a tenant

## Reporting & Analytics
- Company 1—M ReportSchedule
  - Reason: multiple scheduled reports
- Company 1—M KPI
  - Reason: multiple KPIs per tenant

## Polymorphic attachments (Documents, Activities, Events, Tasks)
- Each belongs to exactly one host entity via (entity_type, entity_id)
- Any host entity can have many attachments
- Reason: reuse the same artifact patterns across CRM, billing, and operations

## Cardinality decisions and business rules
- Contact as “client”: All customer-facing relations (Deal, Invoice, Contract, Sale, Revenue) are anchored on Contact to avoid duplicate “client” concepts.
- Payment granularity: Installments accept multiple payments to support partial payments, reversals, and retries.
- Subscription lifecycle: Companies can have a timeline of subscriptions (upgrades/downgrades); enforce at most one active subscription.
- Category allocation: Revenues can be split by category and cost center, thus 0—M from Invoice to Revenue.
- Polymorphic patterns: Documents/Tasks/Events/Activities attach broadly to keep the model DRY and extensible without new junction tables per entity.

Deletion behavior (recommended)
- RESTRICT: Contract → Installment → Payment; BankAccount → Payment/Statement; Invoice → Revenue
- SET NULL: Deal.owner_user_id; Task.assigned_to; created_by on CalendarEvent
- CASCADE: Company → all tenant data (via background jobs) or soft delete with deleted_at

Indexes (relation-heavy)
- (company_id, foreign_key) on all child tables
- Polymorphic: index (company_id, entity_type, entity_id) for Document/Activity/Event/Task
- Unique per tenant: email on User, sku on Product, invoice_number on Invoice, domain_name on CompanyDomain
# Entity Discovery

## Conventions (apply to all tables unless noted)
- Multitenancy: company_id NOT NULL on tenant data; index by (company_id, <business_key>)
- Timestamps: created_at, updated_at; soft delete via deleted_at (nullable)
- Money: use DECIMAL(18,2) + currency; totals stored, derivatives computed
- Idempotency: idempotency_key on external-payment and webhook-facing writes
- Status/Enums: enforce with CHECKs or lookup tables; document allowed values
- Polymorphic refs: for (entity_type, entity_id), index the pair

## Core Business Entities

### Company
**Purpose**: Tenant organization and data isolation container  
**Business Role**: Main entity for multi-tenant architecture  
**Key Attributes**: id, name, address, contact_info, settings

- Company (<u>company_id</u>, name, address_street, address_number, address_postal_code, address_neighborhood, address_city, address_state, phone, website, created_at, updated_at, deleted_at)

### User
**Purpose**: System users with authentication and authorization  
**Business Role**: People who interact with the system  
**Key Attributes**: id, company_id, email, role, profile_data, permissions

- User (<u>user_id</u>, company_id, email, password_hash, first_name, last_name, phone, role, avatar_url, email_verified, is_active, last_login_at, created_at, updated_at, deleted_at)

### Contact
**Purpose**: Customers, leads, and business relationships  
**Business Role**: CRM relationship management  
**Key Attributes**: id, company_id, personal_info, contact_details, status, source

- Contact (<u>contact_id</u>, company_id, type, first_name, last_name, email, phone, company_name, job_title, department, source, status, address_street, address_city, address_country, notes, tags, created_at, updated_at, deleted_at)

### Deal
**Purpose**: Sales opportunities and pipeline management  
**Business Role**: Revenue forecasting and sales process tracking  
**Key Attributes**: id, company_id, contact_id, value, stage, probability, timeline

- Deal (<u>deal_id</u>, company_id, contact_id, owner_user_id, name, description, value, currency, stage, probability, expected_close_date, actual_close_date, status, loss_reason, created_at, updated_at, deleted_at)

### Product
**Purpose**: Sellable products and inventory items  
**Business Role**: Product catalog and inventory management  
**Key Attributes**: id, company_id, name, description, price, stock, category

- Product (<u>product_id</u>, company_id, type, name, description, sku, category, price, cost, currency, tax_rate, is_active, track_inventory, created_at, updated_at, deleted_at)

### Service
**Purpose**: Sellable services and professional offerings  
**Business Role**: Service catalog and delivery tracking  
**Key Attributes**: id, company_id, name, description, price, duration, category

- Service (<u>service_id</u>, company_id, name, description, price, cost, currency, duration, category, is_active, created_at, updated_at, deleted_at)

### Invoice
**Purpose**: Billing documents and financial records  
**Business Role**: Revenue recognition and accounts receivable  
**Key Attributes**: id, company_id, contact_id, amount, status, dates, tax_info

- Invoice (<u>invoice_id</u>, company_id, contact_id, invoice_number, type, status, issue_date, due_date, paid_date, subtotal, tax_amount, total_amount, currency, notes, terms_and_conditions, idempotency_key, created_at, updated_at, deleted_at)

## Subscription & Billing Entities

### Plan
**Purpose**: Defines available subscription tiers and their features/limits  
**Business Role**: Product catalog for subscription plans  
**Key Attributes**: name, pricing, feature_flags, usage_limits, active_status

- Plan (<u>plan_id</u>, name, price_monthly, price_yearly, features, limits, is_active, created_at)

### Subscription
**Purpose**: Tracks a company's active subscription and billing cycle  
**Business Role**: Customer subscription lifecycle management  
**Key Attributes**: company_id, plan_id, plan_snapshot, billing_cycle, status, dates, payment_info

- Subscription (<u>subscription_id</u>, company_id, plan_id, plan_name, price, currency, billing_cycle, status, start_date, end_date, next_billing_date, stripe_subscription_id, idempotency_key, created_at)

## Financial Management Entities

### Revenue
**Purpose**: Track income and revenue recognition  
**Business Role**: Financial performance monitoring  
**Key Attributes**: id, company_id, contact_id, amount, date, category, source

- Revenue (<u>revenue_id</u>, company_id, contact_id, invoice_id, description, amount, revenue_date, category, cost_center_id, created_at, deleted_at)

### RevenueCategory
**Purpose**: Classify types of revenue for reporting  
**Business Role**: Financial analysis and categorization  
**Key Attributes**: id, company_id, name, description, is_active

- RevenueCategory (<u>category_id</u>, company_id, name, description, is_active, created_at)

### Expense
**Purpose**: Track business expenditures and costs  
**Business Role**: Cost management and budgeting  
**Key Attributes**: id, company_id, description, amount, date, category, status

- Expense (<u>expense_id</u>, company_id, description, category, amount, expense_date, vendor, payment_method, status, cost_center_id, created_at, updated_at, deleted_at)

### ExpenseCategory
**Purpose**: Classify types of expenses for reporting  
**Business Role**: Cost analysis and categorization  
**Key Attributes**: id, company_id, name, description, is_active

- ExpenseCategory (<u>category_id</u>, company_id, name, description, is_active, created_at)

### CostCenter
**Purpose**: Organizational units for financial accountability  
**Business Role**: Departmental budgeting and cost allocation  
**Key Attributes**: id, company_id, name, budget, actual_spend, manager

- CostCenter (<u>cost_center_id</u>, company_id, name, description, budget, actual_spend, color, is_active, created_at, updated_at, deleted_at)


### (Phase 2 - Optional) FinancialTransaction
**Purpose**: Unified transaction tracking across all financial activities  
**Business Role**: Comprehensive financial record-keeping  
**Key Attributes**: id, company_id, type, amount, dates, status, related_entities

- FinancialTransaction (<u>transaction_id</u>, company_id, transaction_type, related_entity_type, related_entity_id, amount, due_date, status, paid_date, bank_account_id, cost_center_id, created_at, updated_at)

## Client Lifecycle Management

### ClientApplication
**Purpose**: Prospective client onboarding and qualification  
**Business Role**: Sales pipeline and lead conversion  
**Key Attributes**: id, company_id, prospect_info, business_details, status, timeline

- ClientApplication (<u>application_id</u>, company_id, contact_id, first_name, last_name, email, phone, cpf, cnpj, company_age, company_size, segment, revenue, has_physical_location, credit_purpose, notes, status, converted_at, created_at, updated_at, deleted_at)

### CreditAnalysis
**Purpose**: Risk assessment and credit approval process  
**Business Role**: Underwriting and risk management  
**Key Attributes**: id, company_id, application_id, risk_score, decision, terms

- CreditAnalysis (<u>analysis_id</u>, company_id, client_application_id, analyst_user_id, risk_score, approved_amount, interest_rate, justification, status, created_at)

## Contract & Legal Entities

### Contract
**Purpose**: Legal agreements with clients and partners  
**Business Role**: Relationship formalization and terms management  
**Key Attributes**: id, company_id, contact_id, terms, value, dates, status

- Contract (<u>contract_id</u>, company_id, contact_id, total_value, interest_rate, installment_count, start_date, end_date, status, created_at, updated_at, deleted_at)

### ContractInstallment
**Purpose**: Payment schedule and installment tracking  
**Business Role**: Accounts receivable and cash flow management  
**Key Attributes**: id, contract_id, due_date, amount, status, payment_details

- ContractInstallment (<u>installment_id</u>, contract_id, installment_number, due_date, amount, status, paid_date, late_fee, created_at)

## Banking & Cash Flow

### BankAccount
**Purpose**: Company bank accounts and financial institutions  
**Business Role**: Cash management and reconciliation  
**Key Attributes**: id, company_id, bank_info, account_details, balances

- BankAccount (<u>bank_account_id</u>, company_id, bank_name, agency, account_number, account_type, balance, is_active, created_at, updated_at, deleted_at)

### BankStatementEntry
**Purpose**: Individual bank transactions and statements  
**Business Role**: Financial reconciliation and audit trail  
**Key Attributes**: id, bank_account_id, transaction_details, amounts, dates

- BankStatementEntry (<u>entry_id</u>, bank_account_id, transaction_date, description, amount, transaction_type, balance_after, reference_number, created_at)

### Payment
**Purpose**: Payment processing and transaction records  
**Business Role**: Revenue collection and accounts receivable  
**Key Attributes**: id, company_id, amount, method, date, status, reference

- Payment (<u>payment_id</u>, company_id, contract_installment_id, bank_account_id, amount, payment_date, payment_method, reference_number, status, idempotency_key, created_at)

## Document Management

### Document
**Purpose**: Centralized file and document storage  
**Business Role**: Compliance, record-keeping, and information sharing  
**Key Attributes**: id, company_id, file_data, metadata, access_controls

- Document (<u>document_id</u>, company_id, entity_type, entity_id, document_type, file_name, file_path, file_size, mime_type, storage_provider, bucket, checksum, version, uploaded_by, uploaded_at, expires_at, deleted_at)

## Operational Management

### CalendarEvent
**Purpose**: Scheduling and time management  
**Business Role**: Coordination and appointment tracking  
**Key Attributes**: id, company_id, event_details, participants, timing, reminders

- CalendarEvent (<u>event_id</u>, company_id, title, description, start_time, end_time, entity_type, entity_id, created_by, reminder_sent, status, created_at)

### Task
**Purpose**: Work items and action tracking  
**Business Role**: Productivity and project management  
**Key Attributes**: id, company_id, description, assignee, due_date, status, priority

- Task (<u>task_id</u>, company_id, assigned_to, title, description, due_date, priority, status, entity_type, entity_id, completed_at, created_at, deleted_at)

### Activity
**Purpose**: System interactions and audit trail  
**Business Role**: Compliance monitoring and user behavior tracking  
**Key Attributes**: id, company_id, user_id, action, timestamp, details

- Activity (<u>activity_id</u>, company_id, user_id, contact_id, deal_id, type, subject, description, content, due_date, completed_date, status, created_at, updated_at, deleted_at)

## Inventory & Sales Operations

### Sale
**Purpose**: Sales transactions and order management  
**Business Role**: Revenue tracking and order fulfillment  
**Key Attributes**: id, company_id, contact_id, items, total, dates, status

- Sale (<u>sale_id</u>, company_id, contact_id, total_amount, sale_date, status, payment_terms, created_at, deleted_at)

### SaleItem
**Purpose**: Individual line items within sales  
**Business Role**: Detailed sales analysis and inventory impact  
**Key Attributes**: id, sale_id, product_id, quantity, price, total

- SaleItem (<u>sale_item_id</u>, sale_id, product_id, service_id, quantity, unit_price, total_amount, created_at)
  - Constraint: exactly one of product_id or service_id must be non-null

### InventoryMovement
**Purpose**: Stock changes and inventory adjustments  
**Business Role**: Inventory control and cost of goods sold  
**Key Attributes**: id, company_id, product_id, movement_type, quantity, cost

- InventoryMovement (<u>movement_id</u>, company_id, product_id, movement_type, quantity, unit_cost, reference_id, notes, created_at)

## System & Administration

### AuditLog
**Purpose**: Comprehensive system activity recording  
**Business Role**: Security, compliance, and troubleshooting  
**Key Attributes**: id, company_id, user_id, action, changes, metadata

- AuditLog (<u>log_id</u>, company_id, user_id, action, entity_type, entity_id, old_values, new_values, ip_address, user_agent, timestamp)

### UserRole
**Purpose**: Permission sets and access control groups  
**Business Role**: Security and authorization management  
**Key Attributes**: id, company_id, name, permissions, scope

- UserRole (<u>role_id</u>, company_id, name, permissions, is_system_role, created_at)

### Integration
**Purpose**: Third-party service connections and APIs  
**Business Role**: System extensibility and data synchronization  
**Key Attributes**: id, company_id, service, configuration, status, sync_info

- Integration (<u>integration_id</u>, company_id, service_name, api_key, config_data, is_active, last_sync_at, created_at)

### Notification
**Purpose**: User alerts and communication system  
**Business Role**: User engagement and workflow coordination  
**Key Attributes**: id, company_id, user_id, message, type, status, actions

- Notification (<u>notification_id</u>, company_id, user_id, title, message, type, is_read, action_url, created_at)

## Authentication & Security

### Session
- Session (<u>session_id</u>, user_id, expires_at, created_at)

### PasswordResetToken
- PasswordResetToken (<u>token_id</u>, user_id, token, expires_at, used_at, created_at)

### EmailVerificationToken
- EmailVerificationToken (<u>token_id</u>, user_id, token, expires_at, used_at, created_at)

### OAuthAccount
- OAuthAccount (<u>oauth_account_id</u>, user_id, provider, provider_user_id, access_token, refresh_token, expires_at, created_at, updated_at)

### TwoFactor
- TwoFactor (<u>two_factor_id</u>, user_id, totp_secret, backup_codes, enabled_at, created_at)

## Webhooks & Jobs

### WebhookEndpoint
- WebhookEndpoint (<u>endpoint_id</u>, company_id, url, event_types, secret, is_active, created_at)

### WebhookDelivery
- WebhookDelivery (<u>delivery_id</u>, endpoint_id, event_name, payload, attempt, status, error, next_retry_at, idempotency_key, created_at)

### JobQueue
- JobQueue (<u>job_id</u>, type, payload, run_at, attempts, status, last_error, created_at, updated_at)

## Settings & Configuration

### CompanySettings
**Purpose**: Organization-specific preferences and configuration  
**Business Role**: Tenant customization and system behavior  
**Key Attributes**: company_id, settings_groups, preferences, defaults

- CompanySettings (<u>company_id</u>, razao_social, cnpj, endereco, telefone, logo_ref, theme_settings, security_settings, integration_settings, updated_at)

### TenantSetting
**Purpose**: Individual configuration values per tenant  
**Business Role**: Flexible system customization  
**Key Attributes**: id, company_id, key, value, data_type

- TenantSetting (<u>setting_id</u>, company_id, setting_key, setting_value, data_type, updated_at)

### EmailTemplate
**Purpose**: Standardized communication templates  
**Business Role**: Consistent messaging and branding  
**Key Attributes**: id, company_id, name, content, variables, context

- EmailTemplate (<u>template_id</u>, company_id, name, subject, body, variables, is_active, created_at)

## Reporting & Analytics

### ReportSchedule
**Purpose**: Automated reporting and data exports  
**Business Role**: Business intelligence and performance monitoring  
**Key Attributes**: id, company_id, report_type, frequency, parameters, delivery

- ReportSchedule (<u>schedule_id</u>, company_id, report_type, frequency, parameters, last_run_at, next_run_at, is_active, created_at)

### KPI
**Purpose**: Key performance indicators and metrics  
**Business Role**: Business performance monitoring and goals tracking  
**Key Attributes**: id, company_id, name, calculation, target, current, period

- KPI (<u>kpi_id</u>, company_id, name, calculation_query, target_value, current_value, period, updated_at)

## Multi-tenancy Support

### CompanyDomain
**Purpose**: Custom domains and brand identification  
**Business Role**: White-labeling and tenant identification  
**Key Attributes**: id, company_id, domain, status, verification

- CompanyDomain (<u>domain_id</u>, company_id, domain_name, is_primary, verified_at, created_at)

## Indexes & Constraints (high priority)
- Unique: User.email (global or per company), Product.sku, Invoice.invoice_number, BankAccount (bank_name, agency, account_number), CompanyDomain.domain_name, Plan.name, Subscription.stripe_subscription_id
- Foreign keys: all *_id fields; ON DELETE RESTRICT for financials; ON DELETE SET NULL where appropriate
- Enums:
  - Deal.stage/status
  - Invoice.type/status
  - Payment.status/method
  - Contact.type/status/source
  - Activity.type/status
  - Task.priority/status
  - Contract.status
  - BankStatementEntry.transaction_type (entrada|saida)
- Polymorphic indexes: (entity_type, entity_id) for Document, Activity, CalendarEvent, Task
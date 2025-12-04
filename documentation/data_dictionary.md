# Data Dictionary

## Company

**Description**: Represents a tenant organization, serving as the primary container for data isolation in the multi-tenant architecture.

| Attribute | Data Type | Length (Bytes) | Restrictions | Description |
|---|---|---|---|---|
| company_id | UUID | 16 | PK, NOT NULL | Unique identifier for the company. |
| name | VARCHAR | 255 | NOT NULL | The legal name of the company. |
| address_street | VARCHAR | 255 | | The street name of the company's primary address. |
| address_number | VARCHAR | 50 | | The building or suite number. |
| address_postal_code | VARCHAR | 20 | | The postal code for the address. |
| address_neighborhood | VARCHAR | 100 | | The neighborhood or district. |
| address_city | VARCHAR | 100 | | The city of the address. |
| address_state | VARCHAR | 100 | | The state or province of the address. |
| phone | VARCHAR | 20 | Multi-valued | Contact phone number(s) for the company. Can store multiple values. |
| website | VARCHAR | 255 | | The official website of the company. |
| created_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the company record was created. |
| updated_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the company record was last updated. |
| deleted_at | TIMESTAMP | 8 | NULL | Timestamp for soft deletion of the record. If NULL, the record is active. |

## User

**Description**: Represents system users with authentication and authorization capabilities. These are the individuals who interact with the system.

| Attribute | Data Type | Length (Bytes) | Restrictions | Description |
|---|---|---|---|---|
| user_id | UUID | 16 | PK, NOT NULL | Unique identifier for the user. |
| company_id | UUID | 16 | FK, NOT NULL | Foreign key referencing the company the user belongs to. |
| email | VARCHAR | 255 | NOT NULL, UNIQUE | The user's email address, used for login and communication. Must be unique per company. |
| password_hash | VARCHAR | 255 | NOT NULL | Hashed version of the user's password for secure storage. |
| first_name | VARCHAR | 100 | | The user's first name. |
| last_name | VARCHAR | 100 | | The user's last name. |
| phone | VARCHAR | 20 | | The user's contact phone number. |
| role | VARCHAR | 50 | | The role assigned to the user, determining their permissions. |
| avatar_url | VARCHAR | 255 | | URL for the user's profile picture. |
| email_verified | BOOLEAN | 1 | | Flag indicating if the user has verified their email address. |
| is_active | BOOLEAN | 1 | NOT NULL | Flag indicating if the user account is active. |
| last_login_at | TIMESTAMP | 8 | | Timestamp of the user's last login. |
| created_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the user record was created. |
| updated_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the user record was last updated. |
| deleted_at | TIMESTAMP | 8 | NULL | Timestamp for soft deletion. If NULL, the record is active. |

## Contact

**Description**: Represents customers, leads, and other business relationships. Central to CRM for relationship management.

| Attribute | Data Type | Length (Bytes) | Restrictions | Description |
|---|---|---|---|---|
| contact_id | UUID | 16 | PK, NOT NULL | Unique identifier for the contact. |
| company_id | UUID | 16 | FK, NOT NULL | Foreign key referencing the company that owns this contact. |
| type | VARCHAR | 50 | | The type of contact (e.g., 'Lead', 'Customer', 'Partner'). |
| first_name | VARCHAR | 100 | | The contact's first name. |
| last_name | VARCHAR | 100 | | The contact's last name. |
| email | VARCHAR | 255 | | The contact's primary email address. |
| phone | VARCHAR | 20 | | The contact's primary phone number. |
| company_name | VARCHAR | 255 | | The name of the company the contact works for. |
| job_title | VARCHAR | 100 | | The contact's job title. |
| department | VARCHAR | 100 | | The department the contact works in. |
| source | VARCHAR | 100 | | The source from which the contact was acquired (e.g., 'Website', 'Referral'). |
| status | VARCHAR | 50 | | The current status of the contact in the lifecycle (e.g., 'New', 'Qualified'). |
| address_street | VARCHAR | 255 | | The street name of the contact's address. |
| address_city | VARCHAR | 100 | | The city of the contact's address. |
| address_country | VARCHAR | 100 | | The country of the contact's address. |
| notes | TEXT | | | General notes and comments about the contact. |
| tags | VARCHAR | 255 | | Comma-separated tags for categorization. |
| created_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the contact record was created. |
| updated_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the contact record was last updated. |
| deleted_at | TIMESTAMP | 8 | NULL | Timestamp for soft deletion. If NULL, the record is active. |

## Deal

**Description**: Represents sales opportunities and is used for pipeline management, revenue forecasting, and tracking the sales process.

| Attribute | Data Type | Length (Bytes) | Restrictions | Description |
|---|---|---|---|---|
| deal_id | UUID | 16 | PK, NOT NULL | Unique identifier for the deal. |
| company_id | UUID | 16 | FK, NOT NULL | Foreign key referencing the company that owns this deal. |
| contact_id | UUID | 16 | FK, NOT NULL | Foreign key referencing the primary contact for this deal. |
| owner_user_id | UUID | 16 | FK, NOT NULL | Foreign key referencing the user who owns and manages the deal. |
| name | VARCHAR | 255 | NOT NULL | The name or title of the deal. |
| description | TEXT | | | A detailed description of the sales opportunity. |
| value | DECIMAL | 18, 2 | | The potential or actual monetary value of the deal. |
| currency | VARCHAR | 3 | | The currency code for the deal's value (e.g., 'USD'). |
| stage | VARCHAR | 50 | | The current stage of the deal in the sales pipeline (e.g., 'Prospecting', 'Closed Won'). |
| probability | DECIMAL | 5, 2 | | The probability of winning the deal, expressed as a percentage. |
| expected_close_date | DATE | 4 | | The date when the deal is expected to close. |
| actual_close_date | DATE | 4 | | The date when the deal was actually closed (won or lost). |
| status | VARCHAR | 50 | | The overall status of the deal (e.g., 'Open', 'Won', 'Lost'). |
| loss_reason | TEXT | | | If the deal was lost, the reason for the loss. |
| created_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the deal record was created. |
| updated_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the deal record was last updated. |
| deleted_at | TIMESTAMP | 8 | NULL | Timestamp for soft deletion. If NULL, the record is active. |

## Product

**Description**: Represents sellable products and inventory items, forming the product catalog for sales and inventory management.

| Attribute | Data Type | Length (Bytes) | Restrictions | Description |
|---|---|---|---|---|
| product_id | UUID | 16 | PK, NOT NULL | Unique identifier for the product. |
| company_id | UUID | 16 | FK, NOT NULL | Foreign key referencing the company that owns this product. |
| type | VARCHAR | 50 | | The type of product (e.g., 'Physical', 'Digital'). |
| name | VARCHAR | 255 | NOT NULL | The name of the product. |
| description | TEXT | | | A detailed description of the product. |
| sku | VARCHAR | 100 | UNIQUE | Stock Keeping Unit, a unique identifier for the product within the company. |
| category | VARCHAR | 100 | | The category the product belongs to. |
| price | DECIMAL | 18, 2 | NOT NULL | The selling price of the product. |
| cost | DECIMAL | 18, 2 | | The cost of acquiring the product. |
| currency | VARCHAR | 3 | | The currency code for the price and cost (e.g., 'USD'). |
| tax_rate | DECIMAL | 5, 2 | | The applicable tax rate for the product. |
| is_active | BOOLEAN | 1 | NOT NULL | Flag indicating if the product is currently available for sale. |
| track_inventory | BOOLEAN | 1 | NOT NULL | Flag indicating if stock levels should be tracked for this product. |
| created_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the product record was created. |
| updated_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the product record was last updated. |
| deleted_at | TIMESTAMP | 8 | NULL | Timestamp for soft deletion. If NULL, the record is active. |

## Service

**Description**: Represents sellable services and professional offerings, forming the service catalog.

| Attribute | Data Type | Length (Bytes) | Restrictions | Description |
|---|---|---|---|---|
| service_id | UUID | 16 | PK, NOT NULL | Unique identifier for the service. |
| company_id | UUID | 16 | FK, NOT NULL | Foreign key referencing the company that offers this service. |
| name | VARCHAR | 255 | NOT NULL | The name of the service. |
| description | TEXT | | | A detailed description of the service. |
| price | DECIMAL | 18, 2 | NOT NULL | The price of the service. |
| cost | DECIMAL | 18, 2 | | The cost to the company to provide the service. |
| currency | VARCHAR | 3 | | The currency code for the price and cost (e.g., 'USD'). |
| duration | INTEGER | 4 | | The duration of the service in minutes or hours. |
| category | VARCHAR | 100 | | The category the service belongs to. |
| is_active | BOOLEAN | 1 | NOT NULL | Flag indicating if the service is currently offered. |
| created_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the service record was created. |
| updated_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the service record was last updated. |
| deleted_at | TIMESTAMP | 8 | NULL | Timestamp for soft deletion. If NULL, the record is active. |

## Invoice

**Description**: Represents billing documents and financial records, crucial for revenue recognition and accounts receivable.

| Attribute | Data Type | Length (Bytes) | Restrictions | Description |
|---|---|---|---|---|
| invoice_id | UUID | 16 | PK, NOT NULL | Unique identifier for the invoice. |
| company_id | UUID | 16 | FK, NOT NULL | Foreign key referencing the company that issued the invoice. |
| contact_id | UUID | 16 | FK, NOT NULL | Foreign key referencing the contact being invoiced. |
| invoice_number | VARCHAR | 50 | UNIQUE | A unique number for the invoice within the company. |
| type | VARCHAR | 50 | | The type of invoice (e.g., 'Standard', 'Credit Note'). |
| status | VARCHAR | 50 | | The current status of the invoice (e.g., 'Draft', 'Sent', 'Paid'). |
| issue_date | DATE | 4 | NOT NULL | The date the invoice was issued. |
| due_date | DATE | 4 | | The date the payment is due. |
| paid_date | DATE | 4 | | The date the invoice was paid. |
| subtotal | DECIMAL | 18, 2 | NOT NULL | The total amount before taxes. |
| tax_amount | DECIMAL | 18, 2 | | The total tax amount. |
| total_amount | DECIMAL | 18, 2 | NOT NULL | The final amount due (subtotal + tax). |
| currency | VARCHAR | 3 | | The currency code for the amounts (e.g., 'USD'). |
| notes | TEXT | | | Internal notes about the invoice. |
| terms_and_conditions | TEXT | | | Payment terms and other conditions for the client. |
| idempotency_key | VARCHAR | 255 | | Key to prevent duplicate processing from external systems. |
| created_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the invoice record was created. |
| updated_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the invoice record was last updated. |
| deleted_at | TIMESTAMP | 8 | NULL | Timestamp for soft deletion. If NULL, the record is active. |

## Plan

**Description**: Defines available subscription tiers, their pricing, features, and limits.

| Attribute | Data Type | Length (Bytes) | Restrictions | Description |
|---|---|---|---|---|
| plan_id | UUID | 16 | PK, NOT NULL | Unique identifier for the subscription plan. |
| name | VARCHAR | 255 | NOT NULL, UNIQUE | The name of the plan (e.g., 'Basic', 'Pro'). |
| price_monthly | DECIMAL | 18, 2 | | The monthly price for the plan. |
| price_yearly | DECIMAL | 18, 2 | | The yearly price for the plan. |
| features | JSON | | | A JSON object detailing the features included in the plan. |
| limits | JSON | | | A JSON object detailing the usage limits of the plan. |
| is_active | BOOLEAN | 1 | NOT NULL | Flag indicating if the plan is currently available for new subscriptions. |
| created_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the plan was created. |

## Subscription

**Description**: Tracks a company's active subscription to a plan, managing its lifecycle and billing cycle.

| Attribute | Data Type | Length (Bytes) | Restrictions | Description |
|---|---|---|---|---|
| subscription_id | UUID | 16 | PK, NOT NULL | Unique identifier for the subscription. |
| company_id | UUID | 16 | FK, NOT NULL | Foreign key referencing the company that is subscribed. |
| plan_id | UUID | 16 | FK, NOT NULL | Foreign key referencing the subscribed plan. |
| plan_name | VARCHAR | 255 | | A snapshot of the plan name at the time of subscription. |
| price | DECIMAL | 18, 2 | | A snapshot of the price at the time of subscription. |
| currency | VARCHAR | 3 | | The currency code for the price (e.g., 'USD'). |
| billing_cycle | VARCHAR | 50 | | The billing frequency (e.g., 'monthly', 'yearly'). |
| status | VARCHAR | 50 | | The current status of the subscription (e.g., 'active', 'canceled'). |
| start_date | DATE | 4 | | The date the subscription started. |
| end_date | DATE | 4 | | The date the subscription is scheduled to end or was canceled. |
| next_billing_date | DATE | 4 | | The date of the next scheduled payment. |
| stripe_subscription_id | VARCHAR | 255 | UNIQUE | The identifier from the Stripe payment gateway. |
| idempotency_key | VARCHAR | 255 | | Key to prevent duplicate processing. |
| created_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the subscription record was created. |

## Revenue

**Description**: Tracks income and revenue recognition for financial performance monitoring.

| Attribute | Data Type | Length (Bytes) | Restrictions | Description |
|---|---|---|---|---|
| revenue_id | UUID | 16 | PK, NOT NULL | Unique identifier for the revenue entry. |
| company_id | UUID | 16 | FK, NOT NULL | Foreign key referencing the company. |
| contact_id | UUID | 16 | FK | Foreign key referencing the associated contact. |
| invoice_id | UUID | 16 | FK | Foreign key referencing the associated invoice. |
| description | TEXT | | | Description of the revenue source. |
| amount | DECIMAL | 18, 2 | NOT NULL | The amount of revenue. |
| revenue_date | DATE | 4 | NOT NULL | The date the revenue was recognized. |
| category | VARCHAR | 100 | | The category of revenue. |
| cost_center_id | UUID | 16 | FK | Foreign key referencing the associated cost center. |
| created_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the record was created. |
| deleted_at | TIMESTAMP | 8 | NULL | Timestamp for soft deletion. |

## RevenueCategory

**Description**: Classifies types of revenue for reporting and financial analysis.

| Attribute | Data Type | Length (Bytes) | Restrictions | Description |
|---|---|---|---|---|
| category_id | UUID | 16 | PK, NOT NULL | Unique identifier for the revenue category. |
| company_id | UUID | 16 | FK, NOT NULL | Foreign key referencing the company. |
| name | VARCHAR | 255 | NOT NULL | The name of the category. |
| description | TEXT | | | A description of the category. |
| is_active | BOOLEAN | 1 | NOT NULL | Flag indicating if the category is active. |
| created_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the record was created. |

## Expense

**Description**: Tracks business expenditures and costs for cost management and budgeting.

| Attribute | Data Type | Length (Bytes) | Restrictions | Description |
|---|---|---|---|---|
| expense_id | UUID | 16 | PK, NOT NULL | Unique identifier for the expense entry. |
| company_id | UUID | 16 | FK, NOT NULL | Foreign key referencing the company. |
| description | TEXT | | | Description of the expense. |
| category | VARCHAR | 100 | | The category of the expense. |
| amount | DECIMAL | 18, 2 | NOT NULL | The amount of the expense. |
| expense_date | DATE | 4 | NOT NULL | The date the expense was incurred. |
| vendor | VARCHAR | 255 | | The vendor or supplier. |
| payment_method | VARCHAR | 50 | | The method of payment (e.g., 'Credit Card', 'Bank Transfer'). |
| status | VARCHAR | 50 | | The status of the expense (e.g., 'Pending', 'Paid'). |
| cost_center_id | UUID | 16 | FK | Foreign key referencing the associated cost center. |
| created_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the record was created. |
| updated_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the record was last updated. |
| deleted_at | TIMESTAMP | 8 | NULL | Timestamp for soft deletion. |

## ExpenseCategory

**Description**: Classifies types of expenses for reporting and cost analysis.

| Attribute | Data Type | Length (Bytes) | Restrictions | Description |
|---|---|---|---|---|
| category_id | UUID | 16 | PK, NOT NULL | Unique identifier for the expense category. |
| company_id | UUID | 16 | FK, NOT NULL | Foreign key referencing the company. |
| name | VARCHAR | 255 | NOT NULL | The name of the category. |
| description | TEXT | | | A description of the category. |
| is_active | BOOLEAN | 1 | NOT NULL | Flag indicating if the category is active. |
| created_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the record was created. |

## CostCenter

**Description**: Represents organizational units for financial accountability, used for departmental budgeting and cost allocation.

| Attribute | Data Type | Length (Bytes) | Restrictions | Description |
|---|---|---|---|---|
| cost_center_id | UUID | 16 | PK, NOT NULL | Unique identifier for the cost center. |
| company_id | UUID | 16 | FK, NOT NULL | Foreign key referencing the company. |
| name | VARCHAR | 255 | NOT NULL | The name of the cost center. |
| description | TEXT | | | A description of the cost center. |
| budget | DECIMAL | 18, 2 | | The allocated budget for the cost center. |
| actual_spend | DECIMAL | 18, 2 | | The actual amount spent by the cost center. |
| color | VARCHAR | 7 | | A color code for UI representation. |
| is_active | BOOLEAN | 1 | NOT NULL | Flag indicating if the cost center is active. |
| created_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the record was created. |
| updated_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the record was last updated. |
| deleted_at | TIMESTAMP | 8 | NULL | Timestamp for soft deletion. |

## ClientApplication

**Description**: Manages prospective client onboarding and qualification, feeding the sales pipeline.

| Attribute | Data Type | Length (Bytes) | Restrictions | Description |
|---|---|---|---|---|
| application_id | UUID | 16 | PK, NOT NULL | Unique identifier for the client application. |
| company_id | UUID | 16 | FK, NOT NULL | Foreign key referencing the company. |
| contact_id | UUID | 16 | FK | Foreign key referencing an existing contact, if applicable. |
| first_name | VARCHAR | 100 | | Applicant's first name. |
| last_name | VARCHAR | 100 | | Applicant's last name. |
| email | VARCHAR | 255 | | Applicant's email. |
| phone | VARCHAR | 20 | | Applicant's phone number. |
| cpf | VARCHAR | 14 | | Applicant's individual taxpayer registry code (Brazil). |
| cnpj | VARCHAR | 18 | | Applicant's corporate taxpayer registry code (Brazil). |
| company_age | INTEGER | 4 | | Age of the applicant's company in years. |
| company_size | VARCHAR | 50 | | Size of the applicant's company (e.g., number of employees). |
| segment | VARCHAR | 100 | | The business segment or industry. |
| revenue | DECIMAL | 18, 2 | | The applicant's company annual revenue. |
| has_physical_location | BOOLEAN | 1 | | Flag indicating if the business has a physical location. |
| credit_purpose | TEXT | | | The stated purpose for the credit application. |
| notes | TEXT | | | Internal notes about the application. |
| status | VARCHAR | 50 | | The status of the application (e.g., 'Pending', 'Approved'). |
| converted_at | TIMESTAMP | 8 | | Timestamp when the application was converted to a client. |
| created_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the record was created. |
| updated_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the record was last updated. |
| deleted_at | TIMESTAMP | 8 | NULL | Timestamp for soft deletion. |

## CreditAnalysis

**Description**: Manages the risk assessment and credit approval process for client applications.

| Attribute | Data Type | Length (Bytes) | Restrictions | Description |
|---|---|---|---|---|
| analysis_id | UUID | 16 | PK, NOT NULL | Unique identifier for the credit analysis. |
| company_id | UUID | 16 | FK, NOT NULL | Foreign key referencing the company. |
| client_application_id | UUID | 16 | FK, NOT NULL | Foreign key referencing the client application being analyzed. |
| analyst_user_id | UUID | 16 | FK | Foreign key referencing the user who performed the analysis. |
| risk_score | DECIMAL | 5, 2 | | The calculated risk score for the applicant. |
| approved_amount | DECIMAL | 18, 2 | | The approved credit amount. |
| interest_rate | DECIMAL | 5, 2 | | The approved interest rate. |
| justification | TEXT | | | Justification for the decision. |
| status | VARCHAR | 50 | | The status of the analysis (e.g., 'Approved', 'Rejected'). |
| created_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the record was created. |

## Contract

**Description**: Represents legal agreements with clients, formalizing the relationship and payment terms.

| Attribute | Data Type | Length (Bytes) | Restrictions | Description |
|---|---|---|---|---|
| contract_id | UUID | 16 | PK, NOT NULL | Unique identifier for the contract. |
| company_id | UUID | 16 | FK, NOT NULL | Foreign key referencing the company. |
| contact_id | UUID | 16 | FK, NOT NULL | Foreign key referencing the client contact. |
| total_value | DECIMAL | 18, 2 | NOT NULL | The total value of the contract. |
| interest_rate | DECIMAL | 5, 2 | | The interest rate for the contract. |
| installment_count | INTEGER | 4 | | The number of payment installments. |
| start_date | DATE | 4 | | The start date of the contract. |
| end_date | DATE | 4 | | The end date of the contract. |
| status | VARCHAR | 50 | | The status of the contract (e.g., 'Active', 'Completed'). |
| created_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the record was created. |
| updated_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the record was last updated. |
| deleted_at | TIMESTAMP | 8 | NULL | Timestamp for soft deletion. |

## ContractInstallment

**Description**: Tracks the payment schedule and status of individual installments for a contract.

| Attribute | Data Type | Length (Bytes) | Restrictions | Description |
|---|---|---|---|---|
| installment_id | UUID | 16 | PK, NOT NULL | Unique identifier for the installment. |
| contract_id | UUID | 16 | FK, NOT NULL | Foreign key referencing the parent contract. |
| installment_number | INTEGER | 4 | NOT NULL | The sequence number of the installment. |
| due_date | DATE | 4 | NOT NULL | The date the installment payment is due. |
| amount | DECIMAL | 18, 2 | NOT NULL | The amount due for this installment. |
| status | VARCHAR | 50 | | The status of the installment (e.g., 'Pending', 'Paid', 'Overdue'). |
| paid_date | DATE | 4 | | The date the installment was paid. |
| late_fee | DECIMAL | 18, 2 | | Any late fees applied to this installment. |
| created_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the record was created. |

## BankAccount

**Description**: Represents a company's bank accounts for cash management and reconciliation.

| Attribute | Data Type | Length (Bytes) | Restrictions | Description |
|---|---|---|---|---|
| bank_account_id | UUID | 16 | PK, NOT NULL | Unique identifier for the bank account. |
| company_id | UUID | 16 | FK, NOT NULL | Foreign key referencing the company. |
| bank_name | VARCHAR | 255 | NOT NULL | The name of the financial institution. |
| agency | VARCHAR | 20 | | The bank branch number. |
| account_number | VARCHAR | 50 | | The bank account number. |
| account_type | VARCHAR | 50 | | The type of account (e.g., 'Checking', 'Savings'). |
| balance | DECIMAL | 18, 2 | | The current balance of the account. |
| is_active | BOOLEAN | 1 | NOT NULL | Flag indicating if the account is active. |
| created_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the record was created. |
| updated_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the record was last updated. |
| deleted_at | TIMESTAMP | 8 | NULL | Timestamp for soft deletion. |

## BankStatementEntry

**Description**: Represents individual transactions from a bank statement, used for financial reconciliation.

| Attribute | Data Type | Length (Bytes) | Restrictions | Description |
|---|---|---|---|---|
| entry_id | UUID | 16 | PK, NOT NULL | Unique identifier for the bank statement entry. |
| bank_account_id | UUID | 16 | FK, NOT NULL | Foreign key referencing the bank account. |
| transaction_date | DATE | 4 | NOT NULL | The date of the transaction. |
| description | TEXT | | | The transaction description from the bank statement. |
| amount | DECIMAL | 18, 2 | NOT NULL | The amount of the transaction. |
| transaction_type | VARCHAR | 50 | | The type of transaction (e.g., 'Credit', 'Debit'). |
| balance_after | DECIMAL | 18, 2 | | The account balance after this transaction. |
| reference_number | VARCHAR | 255 | | A reference number for the transaction. |
| created_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the record was created. |

## Payment

**Description**: Records payment processing and transaction details for revenue collection.

| Attribute | Data Type | Length (Bytes) | Restrictions | Description |
|---|---|---|---|---|
| payment_id | UUID | 16 | PK, NOT NULL | Unique identifier for the payment. |
| company_id | UUID | 16 | FK, NOT NULL | Foreign key referencing the company. |
| contract_installment_id | UUID | 16 | FK | Foreign key referencing the contract installment being paid. |
| bank_account_id | UUID | 16 | FK | Foreign key referencing the bank account receiving the payment. |
| amount | DECIMAL | 18, 2 | NOT NULL | The amount paid. |
| payment_date | DATE | 4 | NOT NULL | The date the payment was made. |
| payment_method | VARCHAR | 50 | | The method of payment (e.g., 'Bank Transfer', 'Credit Card'). |
| reference_number | VARCHAR | 255 | | A reference number for the payment. |
| status | VARCHAR | 50 | | The status of the payment (e.g., 'Completed', 'Failed'). |
| idempotency_key | VARCHAR | 255 | | Key to prevent duplicate payment processing. |
| created_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the record was created. |

## Document

**Description**: Provides centralized storage for files and documents, supporting compliance and record-keeping. This is a polymorphic entity.

| Attribute | Data Type | Length (Bytes) | Restrictions | Description |
|---|---|---|---|---|
| document_id | UUID | 16 | PK, NOT NULL | Unique identifier for the document. |
| company_id | UUID | 16 | FK, NOT NULL | Foreign key referencing the company. |
| entity_type | VARCHAR | 50 | NOT NULL | The type of entity this document is associated with (e.g., 'Contact', 'Contract'). |
| entity_id | UUID | 16 | NOT NULL | The ID of the associated entity record. |
| document_type | VARCHAR | 100 | | The type of document (e.g., 'ID', 'Proof of Address'). |
| file_name | VARCHAR | 255 | NOT NULL | The original name of the uploaded file. |
| file_path | VARCHAR | 1024 | NOT NULL | The storage path of the file. |
| file_size | BIGINT | 8 | | The size of the file in bytes. |
| mime_type | VARCHAR | 100 | | The MIME type of the file (e.g., 'application/pdf'). |
| storage_provider | VARCHAR | 50 | | The storage service used (e.g., 'S3', 'local'). |
| bucket | VARCHAR | 255 | | The storage bucket name. |
| checksum | VARCHAR | 255 | | A checksum (e.g., MD5, SHA256) to verify file integrity. |
| version | INTEGER | 4 | | The version number of the document. |
| uploaded_by | UUID | 16 | FK | Foreign key referencing the user who uploaded the document. |
| uploaded_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the document was uploaded. |
| expires_at | TIMESTAMP | 8 | | Timestamp when the document should be considered expired or invalid. |
| deleted_at | TIMESTAMP | 8 | NULL | Timestamp for soft deletion. |

## CalendarEvent

**Description**: Manages scheduling, appointments, and time-based events. This is a polymorphic entity.

| Attribute | Data Type | Length (Bytes) | Restrictions | Description |
|---|---|---|---|---|
| event_id | UUID | 16 | PK, NOT NULL | Unique identifier for the calendar event. |
| company_id | UUID | 16 | FK, NOT NULL | Foreign key referencing the company. |
| title | VARCHAR | 255 | NOT NULL | The title of the event. |
| description | TEXT | | | A detailed description of the event. |
| start_time | TIMESTAMP | 8 | NOT NULL | The start time of the event. |
| end_time | TIMESTAMP | 8 | NOT NULL | The end time of the event. |
| entity_type | VARCHAR | 50 | | The type of entity this event is associated with (e.g., 'Deal', 'Contact'). |
| entity_id | UUID | 16 | | The ID of the associated entity record. |
| created_by | UUID | 16 | FK | Foreign key referencing the user who created the event. |
| reminder_sent | BOOLEAN | 1 | | Flag indicating if a reminder has been sent. |
| status | VARCHAR | 50 | | The status of the event (e.g., 'Scheduled', 'Canceled'). |
| created_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the record was created. |

## Task

**Description**: Represents work items, to-do lists, and other actionable tasks for productivity and project management. This is a polymorphic entity.

| Attribute | Data Type | Length (Bytes) | Restrictions | Description |
|---|---|---|---|---|
| task_id | UUID | 16 | PK, NOT NULL | Unique identifier for the task. |
| company_id | UUID | 16 | FK, NOT NULL | Foreign key referencing the company. |
| assigned_to | UUID | 16 | FK | Foreign key referencing the user the task is assigned to. |
| title | VARCHAR | 255 | NOT NULL | The title of the task. |
| description | TEXT | | | A detailed description of the task. |
| due_date | DATE | 4 | | The date the task is due. |
| priority | VARCHAR | 50 | | The priority of the task (e.g., 'High', 'Low'). |
| status | VARCHAR | 50 | | The status of the task (e.g., 'Not Started', 'Completed'). |
| entity_type | VARCHAR | 50 | | The type of entity this task is associated with (e.g., 'Deal', 'Contact'). |
| entity_id | UUID | 16 | | The ID of the associated entity record. |
| completed_at | TIMESTAMP | 8 | | Timestamp when the task was completed. |
| created_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the record was created. |
| deleted_at | TIMESTAMP | 8 | NULL | Timestamp for soft deletion. |

## Activity

**Description**: Tracks system interactions and serves as an audit trail for user actions and important events.

| Attribute | Data Type | Length (Bytes) | Restrictions | Description |
|---|---|---|---|---|
| activity_id | UUID | 16 | PK, NOT NULL | Unique identifier for the activity. |
| company_id | UUID | 16 | FK, NOT NULL | Foreign key referencing the company. |
| user_id | UUID | 16 | FK | Foreign key referencing the user who performed the activity. |
| contact_id | UUID | 16 | FK | Foreign key referencing the associated contact. |
| deal_id | UUID | 16 | FK | Foreign key referencing the associated deal. |
| type | VARCHAR | 50 | | The type of activity (e.g., 'Call', 'Email', 'Meeting'). |
| subject | VARCHAR | 255 | | The subject or title of the activity. |
| description | TEXT | | | A detailed description of the activity. |
| content | TEXT | | | The content of the activity, such as an email body. |
| due_date | DATE | 4 | | The due date for follow-up activities. |
| completed_date | DATE | 4 | | The date the activity was completed. |
| status | VARCHAR | 50 | | The status of the activity (e.g., 'Planned', 'Held'). |
| created_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the record was created. |
| updated_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the record was last updated. |
| deleted_at | TIMESTAMP | 8 | NULL | Timestamp for soft deletion. |

## Sale

**Description**: Represents sales transactions and orders, used for revenue tracking and order fulfillment.

| Attribute | Data Type | Length (Bytes) | Restrictions | Description |
|---|---|---|---|---|
| sale_id | UUID | 16 | PK, NOT NULL | Unique identifier for the sale. |
| company_id | UUID | 16 | FK, NOT NULL | Foreign key referencing the company. |
| contact_id | UUID | 16 | FK, NOT NULL | Foreign key referencing the contact who made the purchase. |
| total_amount | DECIMAL | 18, 2 | NOT NULL | The total amount of the sale. |
| sale_date | DATE | 4 | NOT NULL | The date the sale occurred. |
| status | VARCHAR | 50 | | The status of the sale (e.g., 'Completed', 'Refunded'). |
| payment_terms | VARCHAR | 100 | | The payment terms for the sale. |
| created_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the record was created. |
| deleted_at | TIMESTAMP | 8 | NULL | Timestamp for soft deletion. |

## SaleItem

**Description**: Represents individual line items within a sale, linking to products or services.

| Attribute | Data Type | Length (Bytes) | Restrictions | Description |
|---|---|---|---|---|
| sale_item_id | UUID | 16 | PK, NOT NULL | Unique identifier for the sale item. |
| sale_id | UUID | 16 | FK, NOT NULL | Foreign key referencing the parent sale. |
| product_id | UUID | 16 | FK | Foreign key referencing the product sold. (Either product_id or service_id must be present). |
| service_id | UUID | 16 | FK | Foreign key referencing the service sold. (Either product_id or service_id must be present). |
| quantity | INTEGER | 4 | NOT NULL | The quantity of the product or service sold. |
| unit_price | DECIMAL | 18, 2 | NOT NULL | The price per unit at the time of sale. |
| total_amount | DECIMAL | 18, 2 | NOT NULL | The total amount for this line item (quantity * unit_price). |
| created_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the record was created. |

## InventoryMovement

**Description**: Tracks stock changes and inventory adjustments for inventory control.

| Attribute | Data Type | Length (Bytes) | Restrictions | Description |
|---|---|---|---|---|
| movement_id | UUID | 16 | PK, NOT NULL | Unique identifier for the inventory movement. |
| company_id | UUID | 16 | FK, NOT NULL | Foreign key referencing the company. |
| product_id | UUID | 16 | FK, NOT NULL | Foreign key referencing the product. |
| movement_type | VARCHAR | 50 | | The type of movement (e.g., 'Purchase', 'Sale', 'Adjustment'). |
| quantity | INTEGER | 4 | NOT NULL | The quantity of items moved. Positive for additions, negative for subtractions. |
| unit_cost | DECIMAL | 18, 2 | | The cost per unit for this movement. |
| reference_id | UUID | 16 | | A reference to the source of the movement (e.g., sale_id, purchase_order_id). |
| notes | TEXT | | | Notes about the inventory movement. |
| created_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the record was created. |

## AuditLog

**Description**: Provides a comprehensive, immutable log of system activities for security, compliance, and troubleshooting.

| Attribute | Data Type | Length (Bytes) | Restrictions | Description |
|---|---|---|---|---|
| log_id | BIGSERIAL | 8 | PK, NOT NULL | Unique, auto-incrementing identifier for the log entry. |
| company_id | UUID | 16 | FK | Foreign key referencing the company where the action occurred. |
| user_id | UUID | 16 | FK | Foreign key referencing the user who performed the action. |
| action | VARCHAR | 255 | NOT NULL | A description of the action performed (e.g., 'user.login', 'contact.create'). |
| entity_type | VARCHAR | 50 | | The type of entity that was changed. |
| entity_id | UUID | 16 | | The ID of the entity that was changed. |
| old_values | JSON | | | A JSON object containing the state of the data before the change. |
| new_values | JSON | | | A JSON object containing the state of the data after the change. |
| ip_address | VARCHAR | 45 | | The IP address from which the action was performed. |
| user_agent | TEXT | | | The user agent string of the client. |
| timestamp | TIMESTAMP | 8 | NOT NULL | Timestamp when the action occurred. |

## UserRole

**Description**: Defines permission sets and access control groups for security and authorization management.

| Attribute | Data Type | Length (Bytes) | Restrictions | Description |
|---|---|---|---|---|
| role_id | UUID | 16 | PK, NOT NULL | Unique identifier for the user role. |
| company_id | UUID | 16 | FK, NOT NULL | Foreign key referencing the company. |
| name | VARCHAR | 100 | NOT NULL | The name of the role (e.g., 'Administrator', 'Sales Rep'). |
| permissions | JSON | | | A JSON object detailing the permissions granted by this role. |
| is_system_role | BOOLEAN | 1 | | Flag indicating if this is a system-level role that cannot be deleted. |
| created_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the record was created. |

## Integration

**Description**: Manages connections to third-party services and APIs for system extensibility and data synchronization.

| Attribute | Data Type | Length (Bytes) | Restrictions | Description |
|---|---|---|---|---|
| integration_id | UUID | 16 | PK, NOT NULL | Unique identifier for the integration. |
| company_id | UUID | 16 | FK, NOT NULL | Foreign key referencing the company. |
| service_name | VARCHAR | 100 | NOT NULL | The name of the integrated service (e.g., 'Stripe', 'Google Calendar'). |
| api_key | VARCHAR | 255 | | The API key for the service (should be encrypted). |
| config_data | JSON | | | A JSON object containing configuration data for the integration. |
| is_active | BOOLEAN | 1 | NOT NULL | Flag indicating if the integration is active. |
| last_sync_at | TIMESTAMP | 8 | | Timestamp of the last successful data synchronization. |
| created_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the record was created. |

## Notification

**Description**: Manages user alerts and in-app communications for engagement and workflow coordination.

| Attribute | Data Type | Length (Bytes) | Restrictions | Description |
|---|---|---|---|---|
| notification_id | UUID | 16 | PK, NOT NULL | Unique identifier for the notification. |
| company_id | UUID | 16 | FK, NOT NULL | Foreign key referencing the company. |
| user_id | UUID | 16 | FK, NOT NULL | Foreign key referencing the user who receives the notification. |
| title | VARCHAR | 255 | NOT NULL | The title of the notification. |
| message | TEXT | | | The content of the notification message. |
| type | VARCHAR | 50 | | The type of notification (e.g., 'Info', 'Alert'). |
| is_read | BOOLEAN | 1 | NOT NULL | Flag indicating if the user has read the notification. |
| action_url | VARCHAR | 255 | | A URL for the user to click to take action. |
| created_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the record was created. |

## Session

**Description**: Manages user authentication sessions.

| Attribute | Data Type | Length (Bytes) | Restrictions | Description |
|---|---|---|---|---|
| session_id | UUID | 16 | PK, NOT NULL | Unique identifier for the session. |
| user_id | UUID | 16 | FK, NOT NULL | Foreign key referencing the authenticated user. |
| expires_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the session expires. |
| created_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the session was created. |

## PasswordResetToken

**Description**: Stores tokens for the password reset process.

| Attribute | Data Type | Length (Bytes) | Restrictions | Description |
|---|---|---|---|---|
| token_id | UUID | 16 | PK, NOT NULL | Unique identifier for the token. |
| user_id | UUID | 16 | FK, NOT NULL | Foreign key referencing the user requesting a password reset. |
| token | VARCHAR | 255 | NOT NULL, UNIQUE | The secure, single-use token. |
| expires_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the token expires. |
| used_at | TIMESTAMP | 8 | | Timestamp when the token was used. |
| created_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the token was created. |

## EmailVerificationToken

**Description**: Stores tokens for the email verification process.

| Attribute | Data Type | Length (Bytes) | Restrictions | Description |
|---|---|---|---|---|
| token_id | UUID | 16 | PK, NOT NULL | Unique identifier for the token. |
| user_id | UUID | 16 | FK, NOT NULL | Foreign key referencing the user verifying their email. |
| token | VARCHAR | 255 | NOT NULL, UNIQUE | The secure, single-use token. |
| expires_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the token expires. |
| used_at | TIMESTAMP | 8 | | Timestamp when the token was used. |
| created_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the token was created. |

## OAuthAccount

**Description**: Links user accounts to third-party OAuth providers (e.g., Google, GitHub).

| Attribute | Data Type | Length (Bytes) | Restrictions | Description |
|---|---|---|---|---|
| oauth_account_id | UUID | 16 | PK, NOT NULL | Unique identifier for the OAuth account link. |
| user_id | UUID | 16 | FK, NOT NULL | Foreign key referencing the local user account. |
| provider | VARCHAR | 50 | NOT NULL | The name of the OAuth provider (e.g., 'google', 'github'). |
| provider_user_id | VARCHAR | 255 | NOT NULL | The user's unique ID from the provider. |
| access_token | TEXT | | | The access token from the provider (should be encrypted). |
| refresh_token | TEXT | | | The refresh token from the provider (should be encrypted). |
| expires_at | TIMESTAMP | 8 | | Timestamp when the access token expires. |
| created_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the record was created. |
| updated_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the record was last updated. |

## TwoFactor

**Description**: Manages two-factor authentication settings for users.

| Attribute | Data Type | Length (Bytes) | Restrictions | Description |
|---|---|---|---|---|
| two_factor_id | UUID | 16 | PK, NOT NULL | Unique identifier for the 2FA setting. |
| user_id | UUID | 16 | FK, NOT NULL | Foreign key referencing the user. |
| totp_secret | VARCHAR | 255 | | The secret key for TOTP generation (should be encrypted). |
| backup_codes | JSON | | | A JSON array of single-use backup codes (should be encrypted). |
| enabled_at | TIMESTAMP | 8 | | Timestamp when 2FA was enabled. |
| created_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the record was created. |

## WebhookEndpoint

**Description**: Stores configuration for outgoing webhooks to notify external systems of events.

| Attribute | Data Type | Length (Bytes) | Restrictions | Description |
|---|---|---|---|---|
| endpoint_id | UUID | 16 | PK, NOT NULL | Unique identifier for the webhook endpoint. |
| company_id | UUID | 16 | FK, NOT NULL | Foreign key referencing the company. |
| url | VARCHAR | 255 | NOT NULL | The URL to which the webhook payload will be sent. |
| event_types | JSON | | | A JSON array of event types that trigger this webhook (e.g., ['deal.created']). |
| secret | VARCHAR | 255 | | A secret key used to sign the webhook payload for verification. |
| is_active | BOOLEAN | 1 | NOT NULL | Flag indicating if the webhook is active. |
| created_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the record was created. |

## WebhookDelivery

**Description**: Logs the delivery attempts of individual webhooks.

| Attribute | Data Type | Length (Bytes) | Restrictions | Description |
|---|---|---|---|---|
| delivery_id | UUID | 16 | PK, NOT NULL | Unique identifier for the delivery attempt. |
| endpoint_id | UUID | 16 | FK, NOT NULL | Foreign key referencing the webhook endpoint. |
| event_name | VARCHAR | 100 | | The name of the event that triggered the delivery. |
| payload | JSON | | | The JSON payload that was sent. |
| attempt | INTEGER | 4 | | The attempt number for this delivery. |
| status | VARCHAR | 50 | | The status of the delivery (e.g., 'Success', 'Failed'). |
| error | TEXT | | | The error message if the delivery failed. |
| next_retry_at | TIMESTAMP | 8 | | Timestamp for the next scheduled retry attempt. |
| idempotency_key | VARCHAR | 255 | | Idempotency key for the delivery. |
| created_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the record was created. |

## JobQueue

**Description**: Manages background jobs and asynchronous tasks.

| Attribute | Data Type | Length (Bytes) | Restrictions | Description |
|---|---|---|---|---|
| job_id | BIGSERIAL | 8 | PK, NOT NULL | Unique, auto-incrementing identifier for the job. |
| type | VARCHAR | 100 | NOT NULL | The type of job to be processed. |
| payload | JSON | | | The JSON payload containing data for the job. |
| run_at | TIMESTAMP | 8 | | The scheduled time to run the job. |
| attempts | INTEGER | 4 | | The number of times the job has been attempted. |
| status | VARCHAR | 50 | | The status of the job (e.g., 'queued', 'running', 'failed'). |
| last_error | TEXT | | | The last error message if the job failed. |
| created_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the job was created. |
| updated_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the job was last updated. |

## CompanySettings

**Description**: Stores organization-specific preferences and configuration. This is a direct 1-to-1 extension of the Company entity.

| Attribute | Data Type | Length (Bytes) | Restrictions | Description |
|---|---|---|---|---|
| company_id | UUID | 16 | PK, FK, NOT NULL | Unique identifier, references `Company.company_id`. |
| razao_social | VARCHAR | 255 | | The legal business name (Brazil). |
| cnpj | VARCHAR | 18 | | The corporate taxpayer registry number (Brazil). |
| endereco | TEXT | | | The full legal address. |
| telefone | VARCHAR | 20 | | The primary contact phone number. |
| logo_ref | VARCHAR | 255 | | A reference or URL to the company's logo. |
| theme_settings | JSON | | | UI theme and branding settings. |
| security_settings | JSON | | | Security-related settings (e.g., password policy). |
| integration_settings | JSON | | | Settings for various integrations. |
| updated_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the settings were last updated. |

## TenantSetting

**Description**: Provides a flexible key-value store for individual tenant configuration.

| Attribute | Data Type | Length (Bytes) | Restrictions | Description |
|---|---|---|---|---|
| setting_id | UUID | 16 | PK, NOT NULL | Unique identifier for the setting. |
| company_id | UUID | 16 | FK, NOT NULL | Foreign key referencing the company. |
| setting_key | VARCHAR | 255 | NOT NULL | The unique key for the setting. |
| setting_value | TEXT | | | The value of the setting. |
| data_type | VARCHAR | 50 | | The data type of the value (e.g., 'string', 'boolean', 'number'). |
| updated_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the setting was last updated. |

## EmailTemplate

**Description**: Stores standardized email communication templates for consistent messaging.

| Attribute | Data Type | Length (Bytes) | Restrictions | Description |
|---|---|---|---|---|
| template_id | UUID | 16 | PK, NOT NULL | Unique identifier for the email template. |
| company_id | UUID | 16 | FK, NOT NULL | Foreign key referencing the company. |
| name | VARCHAR | 255 | NOT NULL | The internal name of the template. |
| subject | VARCHAR | 255 | | The subject line of the email. |
| body | TEXT | | | The HTML or text body of the email. |
| variables | JSON | | | A JSON object describing available placeholder variables. |
| is_active | BOOLEAN | 1 | NOT NULL | Flag indicating if the template is active. |
| created_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the record was created. |

## ReportSchedule

**Description**: Manages automated reporting and data exports for business intelligence.

| Attribute | Data Type | Length (Bytes) | Restrictions | Description |
|---|---|---|---|---|
| schedule_id | UUID | 16 | PK, NOT NULL | Unique identifier for the report schedule. |
| company_id | UUID | 16 | FK, NOT NULL | Foreign key referencing the company. |
| report_type | VARCHAR | 100 | NOT NULL | The type of report to generate. |
| frequency | VARCHAR | 50 | | The frequency of the report (e.g., 'daily', 'weekly'). |
| parameters | JSON | | | A JSON object of parameters for the report generation. |
| last_run_at | TIMESTAMP | 8 | | Timestamp of the last time the report was run. |
| next_run_at | TIMESTAMP | 8 | | Timestamp of the next scheduled run. |
| is_active | BOOLEAN | 1 | NOT NULL | Flag indicating if the schedule is active. |
| created_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the record was created. |

## KPI

**Description**: Tracks Key Performance Indicators (KPIs) and other metrics for business performance monitoring.

| Attribute | Data Type | Length (Bytes) | Restrictions | Description |
|---|---|---|---|---|
| kpi_id | UUID | 16 | PK, NOT NULL | Unique identifier for the KPI. |
| company_id | UUID | 16 | FK, NOT NULL | Foreign key referencing the company. |
| name | VARCHAR | 255 | NOT NULL | The name of the KPI. |
| calculation_query | TEXT | | | The SQL query or logic used to calculate the KPI. |
| target_value | DECIMAL | 18, 2 | | The target value for the KPI. |
| current_value | DECIMAL | 18, 2 | | The most recently calculated value of the KPI. |
| period | VARCHAR | 50 | | The time period the KPI applies to (e.g., 'Q4 2025'). |
| updated_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the KPI was last updated. |

## CompanyDomain

**Description**: Manages custom domains for white-labeling and tenant identification.

| Attribute | Data Type | Length (Bytes) | Restrictions | Description |
|---|---|---|---|---|
| domain_id | UUID | 16 | PK, NOT NULL | Unique identifier for the domain. |
| company_id | UUID | 16 | FK, NOT NULL | Foreign key referencing the company. |
| domain_name | VARCHAR | 255 | NOT NULL, UNIQUE | The custom domain name. |
| is_primary | BOOLEAN | 1 | | Flag indicating if this is the primary domain for the company. |
| verified_at | TIMESTAMP | 8 | | Timestamp when the domain ownership was verified. |
| created_at | TIMESTAMP | 8 | NOT NULL | Timestamp when the record was created. |

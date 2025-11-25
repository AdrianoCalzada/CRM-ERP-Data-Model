# Entity Relationship Summary

This document provides a summary of the relationships between entities in the data model.

## Company

| Entity | Relationship | Relationship Name | Description |
|---|---|---|---|
| Company | User | CompanyHasUser | Defines the one-to-many relationship where a single company can have multiple users. |
| Company | CompanySettings | CompanyHasCompanySettings | Defines the one-to-one relationship where each company has a dedicated set of configuration settings. |
| Company | TenantSettings | CompanyHasTenantSetting | Defines the one-to-many relationship allowing a company to have multiple specific settings for its tenancy. |
| Company | CompanyDomain | CompanyHasCompanyDomain | Defines the one-to-many relationship for associating multiple custom domains with a single company for white-labeling. |
| Company | Contact | CompanyHasContact | Defines the one-to-many relationship where a company can manage a list of multiple contacts (customers, leads, etc.). |
| Company | Product | CompanyHasProduct | Defines the one-to-many relationship for maintaining a catalog of products offered by the company. |
| Company | Service | CompanyHasService | Defines the one-to-many relationship for maintaining a catalog of services offered by the company. |
| Company | Subscription | CompanyHasSubscription | Defines the one-to-many relationship that links a company to its various service subscriptions. |
| Company | BankAccount | CompanyHasBankAccount | Defines the one-to-many relationship for managing multiple bank accounts associated with the company. |
| Company | Integration | CompanyHasIntegration | Defines the one-to-many relationship for managing connections to multiple third-party services. |
| Company | WebhookEndpoint | CompanyHasWebhookEndpoint | Defines the one-to-many relationship for configuring multiple endpoints to which the company can send webhooks. |
| Company | JobQueue | CompanyRunsJob | Defines the one-to-many relationship where a company can have multiple background jobs queued for processing. |
| Company | Notification | CompanyHasNotification | Defines the one-to-many relationship for storing all notifications generated within the context of a company. |
| Company | ReportSchedule | CompanyHasReportSchedule | Defines the one-to-many relationship for managing multiple scheduled reports for a company. |
| Company | KPI | CompanyHasKPI | Defines the one-to-many relationship for tracking multiple Key Performance Indicators (KPIs) for a company. |

## User

| Entity | Relationship | Relationship Name | Description |
|---|---|---|---|
| User | Company | CompanyHasUser | Associates a user with a single company. |
| User | Session | UserHasSession | A user can have multiple active sessions. |
| User | OAuthAccount | UserHasOAuthAccount | A user can have multiple OAuth accounts for different providers. |
| User | TwoFactor | UserHasTwoFactor | A user can have one two-factor authentication setup. |
| User | PasswordVerificationToken | UserHasPasswordResetToken | A user can have multiple password reset tokens. |
| User | EmailVerificationToken | UserHasEmailVerificationToken | A user can have multiple email verification tokens. |
| User | UserRole | UserHasRoleAssignment | A user can be assigned multiple roles, and a role can be assigned to multiple users. |
| User | Deal | UserOwnsDeal | A user can own multiple deals. |
| User | Activity | UserActsInActivity | A user can perform multiple activities. |
| User | Notification | UserHasNotification | A user can receive multiple notifications. |

## Contact

| Entity | Relationship | Relationship Name | Description |
|---|---|---|---|
| Contact | Company | CompanyHasContact | Associates a contact with a single company. |
| Contact | Deal | ContactHasDeal | A contact can be associated with multiple deals. |
| Contact | Activity | ContactHasActivity | A contact can be the subject of multiple activities. |
| Contact | Invoice | ContactHasInvoice | A contact can receive multiple invoices. |
| Contact | Sale | ContactHasSale | A contact can be involved in multiple sales. |
| Contact | Contract | ContactSignsContract | A contact can sign multiple contracts. |

## Deal

| Entity | Relationship | Relationship Name | Description |
|---|---|---|---|
| Deal | Contact | ContactHasDeal | A deal is associated with a single contact. |
| Deal | User | UserOwnsDeal | A deal is owned by a single user. |
| Deal | Activity | DealHasActivity | A deal can have multiple associated activities. |

## Product

| Entity | Relationship | Relationship Name | Description |
|---|---|---|---|
| Product | Company | CompanyHasProduct | A product belongs to a single company. |
| Product | SaleItem | ProductReferencedInSaleItem | A product can be included in multiple sale items. |
| Product | InventoryMovement | ProductHasInventoryMovement | A product can have multiple inventory movements. |

## Service

| Entity | Relationship | Relationship Name | Description |
|---|---|---|---|
| Service | Company | CompanyHasService | A service belongs to a single company. |
| Service | SaleItem | ServiceReferencedInSaleItem | A service can be included in multiple sale items. |

## Invoice

| Entity | Relationship | Relationship Name | Description |
|---|---|---|---|
| Invoice | Contact | ContactHasInvoice | An invoice is issued to a single contact. |
| Invoice | Revenue | InvoiceGeneratesRevenue | An invoice can generate multiple revenue entries. |

## Plan

| Entity | Relationship | Relationship Name | Description |
|---|---|---|---|
| Plan | Subscription | PlanHasSubscription | A plan can be associated with multiple subscriptions. |

## Subscription

| Entity | Relationship | Relationship Name | Description |
|---|---|---|---|
| Subscription | Plan | PlanHasSubscription | A subscription is based on a single plan. |
| Subscription | Company | CompanyHasSubscription | A subscription belongs to a single company. |

## Revenue

| Entity | Relationship | Relationship Name | Description |
|---|---|---|---|
| Revenue | Invoice | InvoiceGeneratesRevenue | Revenue is generated from a single invoice. |
| Revenue | RevenueCategory | RevenueCategorizedByCategory | Revenue is classified under a single category. |
| Revenue | CostCenter | RevenueAllocatedToCostCenter | Revenue can be allocated to a single cost center. |

## Expense

| Entity | Relationship | Relationship Name | Description |
|---|---|---|---|
| Expense | ExpenseCategory | ExpenseCategorizedByCategory | An expense is classified under a single category. |
| Expense | CostCenter | ExpenseAllocatedToCostCenter | An expense can be allocated to a single cost center. |

## Contract

| Entity | Relationship | Relationship Name | Description |
|---|---|---|---|
| Contract | Contact | ContactSignsContract | A contract is signed by a single contact. |
| Contract | ContractInstallment | ContractHasInstallment | A contract can have multiple installments. |

## ContractInstallment

| Entity | Relationship | Relationship Name | Description |
|---|---|---|---|
| ContractInstallment | Contract | ContractHasInstallment | An installment is part of a single contract. |
| ContractInstallment | Payment | InstallmentReceivesPayment | An installment can receive multiple payments. |

## BankAccount

| Entity | Relationship | Relationship Name | Description |
|---|---|---|---|
| BankAccount | Company | CompanyHasBankAccount | A bank account belongs to a single company. |
| BankAccount | BankStatementEntry | BankAccountHasStatementEntry | A bank account can have multiple statement entries. |
| BankAccount | Payment | BankAccountSettlesPayment | A bank account can be used to settle multiple payments. |

## Payment

| Entity | Relationship | Relationship Name | Description |
|---|---|---|---|
| Payment | ContractInstallment | InstallmentReceivesPayment | A payment is made for a single contract installment. |
| Payment | BankAccount | BankAccountSettlesPayment | A payment is settled through a single bank account. |

## Sale

| Entity | Relationship | Relationship Name | Description |
|---|---|---|---|
| Sale | Contact | ContactHasSale | A sale is made to a single contact. |
| Sale | SaleItem | SaleHasSaleItem | A sale can consist of multiple sale items. |

## SaleItem

| Entity | Relationship | Relationship Name | Description |
|---|---|---|---|
| SaleItem | Sale | SaleHasSaleItem | A sale item is part of a single sale. |
| SaleItem | Product | ProductReferencedInSaleItem | A sale item can reference a single product. |
| SaleItem | Service | ServiceReferencedInSaleItem | A sale item can reference a single service. |

## InventoryMovement

| Entity | Relationship | Relationship Name | Description |
|---|---|---|---|
| InventoryMovement | Product | ProductHasInventoryMovement | An inventory movement is for a single product. |

## WebhookEndpoint

| Entity | Relationship | Relationship Name | Description |
|---|---|---|---|
| WebhookEndpoint | Company | CompanyHasWebhookEndpoint | A webhook endpoint belongs to a single company. |
| WebhookEndpoint | WebhookDelivery | WebhookEndpointHasDelivery | A webhook endpoint can have multiple delivery attempts. |

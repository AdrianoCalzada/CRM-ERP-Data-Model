# Entity Relationship Summary

This document provides a summary of the relationships between entities in the data model.

## Company

| Relationship | Relationship Name | Description |
|---|---|---|
| User | CompanyHasUser | Defines the one-to-many relationship where a single company can have multiple users. |
| CompanySettings | CompanyHasCompanySettings | Defines the one-to-one relationship where each company has a dedicated set of configuration settings. |
| TenantSettings | CompanyHasTenantSetting | Defines the one-to-many relationship allowing a company to have multiple specific settings for its tenancy. |
| CompanyDomain | CompanyHasCompanyDomain | Defines the one-to-many relationship for associating multiple custom domains with a single company for white-labeling. |
| Contact | CompanyHasContact | Defines the one-to-many relationship where a company can manage a list of multiple contacts (customers, leads, etc.). |
| Product | CompanyHasProduct | Defines the one-to-many relationship for maintaining a catalog of products offered by the company. |
| Service | CompanyHasService | Defines the one-to-many relationship for maintaining a catalog of services offered by the company. |
| Subscription | CompanyHasSubscription | Defines the one-to-many relationship that links a company to its various service subscriptions. |
| BankAccount | CompanyHasBankAccount | Defines the one-to-many relationship for managing multiple bank accounts associated with the company. |
| Integration | CompanyHasIntegration | Defines the one-to-many relationship for managing connections to multiple third-party services. |
| WebhookEndpoint | CompanyHasWebhookEndpoint | Defines the one-to-many relationship for configuring multiple endpoints to which the company can send webhooks. |
| JobQueue | CompanyRunsJob | Defines the one-to-many relationship where a company can have multiple background jobs queued for processing. |
| Notification | CompanyHasNotification | Defines the one-to-many relationship for storing all notifications generated within the context of a company. |
| ReportSchedule | CompanyHasReportSchedule | Defines the one-to-many relationship for managing multiple scheduled reports for a company. |
| KPI | CompanyHasKPI | Defines the one-to-many relationship for tracking multiple Key Performance Indicators (KPIs) for a company. |

## User

| Relationship | Relationship Name | Description |
|---|---|---|
| Company | CompanyHasUser | Associates a user with a single company. |
| Session | UserHasSession | A user can have multiple active sessions. |
| OAuthAccount | UserHasOAuthAccount | A user can have multiple OAuth accounts for different providers. |
| TwoFactor | UserHasTwoFactor | A user can have one two-factor authentication setup. |
| PasswordVerificationToken | UserHasPasswordResetToken | A user can have multiple password reset tokens. |
| EmailVerificationToken | UserHasEmailVerificationToken | A user can have multiple email verification tokens. |
| UserRole | UserHasRoleAssignment | A user can be assigned multiple roles, and a role can be assigned to multiple users. |
| Deal | UserOwnsDeal | A user can own multiple deals. |
| Activity | UserActsInActivity | A user can perform multiple activities. |
| Notification | UserHasNotification | A user can receive multiple notifications. |

## Contact

| Relationship | Relationship Name | Description |
|---|---|---|
| Company | CompanyHasContact | Associates a contact with a single company. |
| Deal | ContactHasDeal | A contact can be associated with multiple deals. |
| Activity | ContactHasActivity | A contact can be the subject of multiple activities. |
| Invoice | ContactHasInvoice | A contact can receive multiple invoices. |
| Sale | ContactHasSale | A contact can be involved in multiple sales. |
| Contract | ContactSignsContract | A contact can sign multiple contracts. |

## Deal

| Relationship | Relationship Name | Description |
|---|---|---|
| Contact | ContactHasDeal | A deal is associated with a single contact. |
| User | UserOwnsDeal | A deal is owned by a single user. |
| Activity | DealHasActivity | A deal can have multiple associated activities. |

## Product

| Relationship | Relationship Name | Description |
|---|---|---|
| Company | CompanyHasProduct | A product belongs to a single company. |
| SaleItem | ProductReferencedInSaleItem | A product can be included in multiple sale items. |
| InventoryMovement | ProductHasInventoryMovement | A product can have multiple inventory movements. |

## Service

| Relationship | Relationship Name | Description |
|---|---|---|
| Company | CompanyHasService | A service belongs to a single company. |
| SaleItem | ServiceReferencedInSaleItem | A service can be included in multiple sale items. |

## Invoice

| Relationship | Relationship Name | Description |
|---|---|---|
| Contact | ContactHasInvoice | An invoice is issued to a single contact. |
| Revenue | InvoiceGeneratesRevenue | An invoice can generate multiple revenue entries. |

## Plan

| Relationship | Relationship Name | Description |
|---|---|---|
| Subscription | PlanHasSubscription | A plan can be associated with multiple subscriptions. |

## Subscription

| Relationship | Relationship Name | Description |
|---|---|---|
| Plan | PlanHasSubscription | A subscription is based on a single plan. |
| Company | CompanyHasSubscription | A subscription belongs to a single company. |

## Revenue

| Relationship | Relationship Name | Description |
|---|---|---|
| Invoice | InvoiceGeneratesRevenue | Revenue is generated from a single invoice. |
| RevenueCategory | RevenueCategorizedByCategory | Revenue is classified under a single category. |
| CostCenter | RevenueAllocatedToCostCenter | Revenue can be allocated to a single cost center. |

## Expense

| Relationship | Relationship Name | Description |
|---|---|---|
| ExpenseCategory | ExpenseCategorizedByCategory | An expense is classified under a single category. |
| CostCenter | ExpenseAllocatedToCostCenter | An expense can be allocated to a single cost center. |

## Contract

| Relationship | Relationship Name | Description |
|---|---|---|
| Contact | ContactSignsContract | A contract is signed by a single contact. |
| ContractInstallment | ContractHasInstallment | A contract can have multiple installments. |

## ContractInstallment

| Relationship | Relationship Name | Description |
|---|---|---|
| Contract | ContractHasInstallment | An installment is part of a single contract. |
| Payment | InstallmentReceivesPayment | An installment can receive multiple payments. |

## BankAccount

| Relationship | Relationship Name | Description |
|---|---|---|
| Company | CompanyHasBankAccount | A bank account belongs to a single company. |
| BankStatementEntry | BankAccountHasStatementEntry | A bank account can have multiple statement entries. |
| Payment | BankAccountSettlesPayment | A bank account can be used to settle multiple payments. |

## Payment

| Relationship | Relationship Name | Description |
|---|---|---|
| ContractInstallment | InstallmentReceivesPayment | A payment is made for a single contract installment. |
| BankAccount | BankAccountSettlesPayment | A payment is settled through a single bank account. |

## Sale

| Relationship | Relationship Name | Description |
|---|---|---|
| Contact | ContactHasSale | A sale is made to a single contact. |
| SaleItem | SaleHasSaleItem | A sale can consist of multiple sale items. |

## SaleItem

| Relationship | Relationship Name | Description |
|---|---|---|
| Sale | SaleHasSaleItem | A sale item is part of a single sale. |
| Product | ProductReferencedInSaleItem | A sale item can reference a single product. |
| Service | ServiceReferencedInSaleItem | A sale item can reference a single service. |

## InventoryMovement

| Relationship | Relationship Name | Description |
|---|---|---|
| Product | ProductHasInventoryMovement | An inventory movement is for a single product. |

## WebhookEndpoint

| Relationship | Relationship Name | Description |
|---|---|---|
| Company | CompanyHasWebhookEndpoint | A webhook endpoint belongs to a single company. |
| WebhookDelivery | WebhookEndpointHasDelivery | A webhook endpoint can have multiple delivery attempts. |

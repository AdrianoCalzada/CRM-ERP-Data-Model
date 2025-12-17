# Diagram Version History

## Information Engineering Diagram (Crow's Foot Notation)

### v1: Initial Logical Model Translation

This version transforms the Peter Chen conceptual model into an Information Engineering diagram using crow's foot notation. It includes all entities identified in the conceptual phase, with their respective attributes mapped to database-ready columns. All primary keys, foreign keys, and multi-valued attributes are represented in their logical form.

![Logical model with all entities and relationships](/out/diagrams/information_engineering_diagram.svg)

### v2: First Normal Form

This version eliminates all multi-valued attributes and non-atomic data to achieve First Normal Form (1NF) compliance. All JSON arrays and comma-separated values have been decomposed into separate junction tables, ensuring that each cell contains only a single, indivisible value.

**Key changes:**
- **CompanyPhone** table: Replaces multi-valued `phone` attribute in Company
- **ContactTag** table: Replaces multi-valued `tags` attribute in Contact
- **PlanFeature & PlanLimit** tables: Replace JSON `features` and `limits` in Plan
- **BackupCode** table: Replaces JSON `backup_codes` in TwoFactor
- **WebhookEventType** table: Replaces JSON `event_types` in WebhookEndpoint

![First normal form](/out/diagrams/first_normal_form.svg)

### v3: Second Normal Form

This version eliminates partial dependencies to achieve Second Normal Form (2NF) compliance. In tables with composite primary keys, all non-key attributes must depend on the entire primary key, not just part of it.

**Key changes:**
- **Subscription** table: Removed `plan_name` and `price` attributes that partially depended on `plan_id` rather than the full composite key. These values can be retrieved via JOIN with the Plan table when needed.

All other entities were already 2NF compliant, as they have single primary keys with no partial dependencies. Junction tables maintain proper 2NF structure with all non-key attributes depending on their composite keys.

![Second normal form](/out/diagrams/second_normal_form.svg)

### v4: Third Normal Form

This version eliminates transitive dependencies to achieve Third Normal Form (3NF) compliance. Non-key attributes must not depend on other non-key attributes; they must depend directly on the primary key only.

**Key changes:**
- **Removed calculated/derived fields:**
  - `CostCenter.actual_spend`: Calculated from Expense table, should not be stored
  - `KPI.current_value`: Computed from `calculation_query`, should not be stored

- **Centralized currency management:**
  - Removed `currency` from Deal, Product, Service, Invoice, and Subscription entities
  - Added `default_currency` to CompanySettings as the single source of truth for company currency
  - This eliminates transitive dependencies where currency was stored redundantly across multiple entities

- **Preserved denormalization for business purposes:**
  - `Contact.company_name`: Kept for audit/historical purposes (captures company name at time of contact creation)
  - `CostCenter.color`: Kept as metadata/UI styling preference (not derived, independent attribute)

![Third normal form](/out/diagrams/third_normal_form.svg)
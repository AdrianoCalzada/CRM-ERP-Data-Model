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

This normalization ensures data integrity, eliminates update anomalies, and provides better query flexibility for accessing related data.

![First normal form](/out/diagrams/first_normal_form.svg)
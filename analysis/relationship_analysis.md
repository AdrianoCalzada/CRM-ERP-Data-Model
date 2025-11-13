# Relationship Analysis - How Entities Connect

## Primary Relationships
- Company HAS MANY Users
- Company HAS MANY Contacts
- User MANAGES MANY Contacts
- Contact HAS MANY Deals
- Deal INCLUDES MANY Products

## Cardinality Analysis
- One-to-Many: Company → Users, Company → Contacts
- Many-to-Many: Deals ↔ Products (through deal_items)
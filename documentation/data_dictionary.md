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

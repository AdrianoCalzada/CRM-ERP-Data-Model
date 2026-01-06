# Schema Snapshots

This folder is reserved for **schema snapshots** (optional): a single, compiled SQL file representing the current structure of the database at a given point in time.

Recommended workflow:
- Use `database/migrations/` as the source of truth.
- Optionally generate a snapshot later (e.g., for onboarding or review).

If you don’t need snapshots, you can leave this folder empty.

-- 0090_indexes.sql
SET search_path TO app, public;

-- Foreign key indexes (Postgres does NOT create these automatically)
CREATE INDEX IF NOT EXISTS idx_user_company_id ON "user"(company_id);
CREATE INDEX IF NOT EXISTS idx_session_user_id ON session(user_id);
CREATE INDEX IF NOT EXISTS idx_user_role_company_id ON user_role(company_id);
CREATE INDEX IF NOT EXISTS idx_user_user_role_role_id ON user_user_role(role_id);

CREATE INDEX IF NOT EXISTS idx_contact_company_id ON contact(company_id);
CREATE INDEX IF NOT EXISTS idx_contact_tag_contact_id ON contact_tag(contact_id);

CREATE INDEX IF NOT EXISTS idx_deal_company_id ON deal(company_id);
CREATE INDEX IF NOT EXISTS idx_deal_contact_id ON deal(contact_id);
CREATE INDEX IF NOT EXISTS idx_deal_owner_user_id ON deal(owner_user_id);

CREATE INDEX IF NOT EXISTS idx_activity_company_id ON activity(company_id);
CREATE INDEX IF NOT EXISTS idx_activity_user_id ON activity(user_id);
CREATE INDEX IF NOT EXISTS idx_activity_contact_id ON activity(contact_id);
CREATE INDEX IF NOT EXISTS idx_activity_deal_id ON activity(deal_id);
CREATE INDEX IF NOT EXISTS idx_activity_entity ON activity(entity_type, entity_id);

CREATE INDEX IF NOT EXISTS idx_task_company_id ON task(company_id);
CREATE INDEX IF NOT EXISTS idx_task_assigned_to ON task(assigned_to);
CREATE INDEX IF NOT EXISTS idx_task_entity ON task(entity_type, entity_id);

CREATE INDEX IF NOT EXISTS idx_calendar_event_company_id ON calendar_event(company_id);
CREATE INDEX IF NOT EXISTS idx_calendar_event_created_by ON calendar_event(created_by);
CREATE INDEX IF NOT EXISTS idx_calendar_event_entity ON calendar_event(entity_type, entity_id);

CREATE INDEX IF NOT EXISTS idx_document_company_id ON document(company_id);
CREATE INDEX IF NOT EXISTS idx_document_uploaded_by ON document(uploaded_by);
CREATE INDEX IF NOT EXISTS idx_document_entity ON document(entity_type, entity_id);

CREATE INDEX IF NOT EXISTS idx_product_company_id ON product(company_id);
CREATE INDEX IF NOT EXISTS idx_service_company_id ON service(company_id);

CREATE INDEX IF NOT EXISTS idx_sale_company_id ON sale(company_id);
CREATE INDEX IF NOT EXISTS idx_sale_contact_id ON sale(contact_id);
CREATE INDEX IF NOT EXISTS idx_sale_item_sale_id ON sale_item(sale_id);
CREATE INDEX IF NOT EXISTS idx_sale_item_product_id ON sale_item(product_id);
CREATE INDEX IF NOT EXISTS idx_sale_item_service_id ON sale_item(service_id);

CREATE INDEX IF NOT EXISTS idx_inventory_movement_company_id ON inventory_movement(company_id);
CREATE INDEX IF NOT EXISTS idx_inventory_movement_product_id ON inventory_movement(product_id);

CREATE INDEX IF NOT EXISTS idx_invoice_company_id ON invoice(company_id);
CREATE INDEX IF NOT EXISTS idx_invoice_contact_id ON invoice(contact_id);

CREATE INDEX IF NOT EXISTS idx_subscription_company_id ON subscription(company_id);
CREATE INDEX IF NOT EXISTS idx_subscription_plan_id ON subscription(plan_id);

CREATE INDEX IF NOT EXISTS idx_cost_center_company_id ON cost_center(company_id);

CREATE INDEX IF NOT EXISTS idx_revenue_company_id ON revenue(company_id);
CREATE INDEX IF NOT EXISTS idx_revenue_contact_id ON revenue(contact_id);
CREATE INDEX IF NOT EXISTS idx_revenue_invoice_id ON revenue(invoice_id);
CREATE INDEX IF NOT EXISTS idx_revenue_cost_center_id ON revenue(cost_center_id);

CREATE INDEX IF NOT EXISTS idx_expense_company_id ON expense(company_id);
CREATE INDEX IF NOT EXISTS idx_expense_cost_center_id ON expense(cost_center_id);

CREATE INDEX IF NOT EXISTS idx_bank_account_company_id ON bank_account(company_id);
CREATE INDEX IF NOT EXISTS idx_bank_statement_entry_bank_account_id ON bank_statement_entry(bank_account_id);

CREATE INDEX IF NOT EXISTS idx_contract_company_id ON contract(company_id);
CREATE INDEX IF NOT EXISTS idx_contract_contact_id ON contract(contact_id);
CREATE INDEX IF NOT EXISTS idx_contract_installment_contract_id ON contract_installment(contract_id);

CREATE INDEX IF NOT EXISTS idx_client_application_company_id ON client_application(company_id);
CREATE INDEX IF NOT EXISTS idx_client_application_contact_id ON client_application(contact_id);
CREATE INDEX IF NOT EXISTS idx_credit_analysis_company_id ON credit_analysis(company_id);
CREATE INDEX IF NOT EXISTS idx_credit_analysis_client_application_id ON credit_analysis(client_application_id);
CREATE INDEX IF NOT EXISTS idx_credit_analysis_analyst_user_id ON credit_analysis(analyst_user_id);

CREATE INDEX IF NOT EXISTS idx_payment_company_id ON payment(company_id);
CREATE INDEX IF NOT EXISTS idx_payment_contract_installment_id ON payment(contract_installment_id);
CREATE INDEX IF NOT EXISTS idx_payment_bank_account_id ON payment(bank_account_id);

CREATE INDEX IF NOT EXISTS idx_integration_company_id ON integration(company_id);
CREATE INDEX IF NOT EXISTS idx_webhook_endpoint_company_id ON webhook_endpoint(company_id);
CREATE INDEX IF NOT EXISTS idx_webhook_event_type_endpoint_id ON webhook_event_type(endpoint_id);
CREATE INDEX IF NOT EXISTS idx_webhook_delivery_endpoint_id ON webhook_delivery(endpoint_id);

CREATE INDEX IF NOT EXISTS idx_notification_company_id ON notification(company_id);
CREATE INDEX IF NOT EXISTS idx_notification_user_id ON notification(user_id);

CREATE INDEX IF NOT EXISTS idx_report_schedule_company_id ON report_schedule(company_id);
CREATE INDEX IF NOT EXISTS idx_kpi_company_id ON kpi(company_id);

CREATE INDEX IF NOT EXISTS idx_audit_log_company_id ON audit_log(company_id);
CREATE INDEX IF NOT EXISTS idx_audit_log_user_id ON audit_log(user_id);
CREATE INDEX IF NOT EXISTS idx_audit_log_entity ON audit_log(entity_type, entity_id);

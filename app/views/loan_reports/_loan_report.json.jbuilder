json.extract! loan_report, :id, :loan_id, :member_name, :amount, :interest_rate, :total_amount_after_deduction, :repayment_status, :approval_status, :status, :total_repaid, :outstanding_balance, :created_at, :updated_at
json.url loan_report_url(loan_report, format: :json)

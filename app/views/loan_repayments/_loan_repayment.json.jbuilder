json.extract! loan_repayment, :id, :loan_id, :member_id, :payment_amount, :payment_date, :note, :created_at, :updated_at
json.url loan_repayment_url(loan_repayment, format: :json)

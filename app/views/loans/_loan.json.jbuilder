json.extract! loan, :id, :member_id, :amount, :interest_rate, :status, :created_at, :updated_at
json.url loan_url(loan, format: :json)

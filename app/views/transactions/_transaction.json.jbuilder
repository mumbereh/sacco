json.extract! transaction, :id, :account_id, :transaction_type, :amount, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)

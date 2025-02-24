json.extract! savings_commitment, :id, :member_id, :target_amount, :monthly_contribution, :status, :created_at, :updated_at
json.url savings_commitment_url(savings_commitment, format: :json)

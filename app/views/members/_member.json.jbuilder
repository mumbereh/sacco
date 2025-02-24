json.extract! member, :id, :name, :email, :phone, :address, :created_at, :updated_at
json.url member_url(member, format: :json)

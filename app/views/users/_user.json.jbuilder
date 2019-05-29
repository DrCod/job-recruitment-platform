json.extract! user, :id, :name, :email, :address, :phone, :password, :password_confirm, :created_at, :updated_at
json.url user_url(user, format: :json)

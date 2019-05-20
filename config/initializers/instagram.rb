Instagram.configure do |config|
  config.client_id = Rails.application.credentials.instagram_client_id
  config.client_secret = Rails.application.credentials.instagram_client_secret
end

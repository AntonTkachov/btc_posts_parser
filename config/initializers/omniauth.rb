Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, Rails.application.secrets.app_id, Rails.application.secrets.secret, scope: 'manage_pages publish_pages publish_actions'
end
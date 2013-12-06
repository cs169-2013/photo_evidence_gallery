if Rails.env.production?
  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :facebook, ENV['FACEBOOK_KEY_PRODUCTION'], ENV['FACEBOOK_SECRET_PRODUCTION'],
             :scope => 'publish_stream'
  end
else
  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :facebook, ENV['FACEBOOK_KEY_TEST'], ENV['FACEBOOK_SECRET_TEST'],
             :scope => 'publish_stream'
  end
end

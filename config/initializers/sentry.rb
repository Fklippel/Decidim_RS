require 'sentry-ruby'

Sentry.init do |config|
  config.dsn = ENV["SENTRY_DSN"] 

  # Add data like request headers and IP for users,
  # see https://docs.sentry.io/platforms/ruby/data-management/data-collected/ for more info
  config.send_default_pii = true
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]
end

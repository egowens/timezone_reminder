TimezoneReminder::Application.configure do
  config.cache_classes = false
  config.eager_load = false
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = true

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  #set delivery methods to :smtp, :sendmail, or :test
#  config.action_mailer.delivery_method = :smtp

  #These options are only for :smpt delivery
#  config.action_mailer.smtp_settings = {
#    :address          => "smtp.example.com",
#    :port             => 25,
#    :domain           => "www.example.com",
#    :authentication   => :login,
#    :user_name        => "www",
#    :password         => "secret"
#  }
end

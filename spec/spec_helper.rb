ENV["RAILS_ENV"] ||= 'test'
ENV['HUSH_REDIS_URL']      = 'redis://localhost:6379'
ENV['HUSH_ENCRYPTION_KEY'] = 'blah'

require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.infer_base_class_for_anonymous_controllers = false

  config.order = "random"
end

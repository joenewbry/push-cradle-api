ENV['RAILS_ENV'] = 'test'

require File.expand_path('../../config/environment', __FILE__)

require 'rspec/rails'
require 'webmock/rspec'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |file| require file }

RSpec.configure do |config|

  config.infer_spec_type_from_file_location!
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.fail_fast = true
  config.infer_base_class_for_anonymous_controllers = false
  config.order = 'random'
  config.use_transactional_fixtures = false
end

WebMock.disable_net_connect!(allow_localhost: true)

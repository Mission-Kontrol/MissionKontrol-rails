# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path("../../test/dummy/config/environment.rb", __FILE__)

require 'rspec/rails'

ENGINE_RAILS_ROOT=File.join(File.dirname(__FILE__), '../')

ActiveRecord::Migrator.migrations_paths = [File.expand_path("../../test/dummy/db/migrate", __FILE__)]
ActiveRecord::Migrator.migrations_paths << File.expand_path('../../db/migrate', __FILE__)
# Prevent database truncation if the environment is production
abort('The Rails environment is in production mode!') if Rails.env.production?

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.backtrace_exclusion_patterns = [
    %r{gems\/activesupport},
    %r{gems\/actionpack},
    %r{gems\/rspec}
  ]

  config.use_transactional_fixtures = true
end

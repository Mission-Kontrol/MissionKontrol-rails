# frozen_string_literal: true

# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path("../../test/dummy/config/environment.rb", __FILE__)
# Prevent database truncation if the environment is production
abort('The Rails environment is in production mode!') if Rails.env.production?
require 'rspec/rails'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.backtrace_exclusion_patterns = [
    %r{gems\/activesupport},
    %r{gems\/actionpack},
    %r{gems\/rspec}
  ]

  config.use_transactional_fixtures = false
end
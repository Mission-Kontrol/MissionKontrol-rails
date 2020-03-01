# frozen_string_literal: true

require 'rails/generators'
require 'securerandom'

module MissionKontrolRelay
  module Generators
    class MissionKontrolRelayGenerator < Rails::Generators::Base
      def generate_token_for_variable
        ENV['MISSION_KONTROL_TOKEN'] = SecureRandom.uuid
      end
    end
  end
end

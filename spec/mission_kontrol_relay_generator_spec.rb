# frozen_string_literal: true

require 'generator_spec'
require 'generators/mission_kontrol_relay/mission_kontrol_relay_generator'

RSpec.describe MissionKontrolRelay::Generators::MissionKontrolRelayGenerator, type: :generator do
  it 'generates a random token and saves to MISSION_KONTROL_TOKEN environment variable' do
    expect(ENV['MISSION_KONTROL_TOKEN']).to be nil

    run_generator

    expect(ENV['MISSION_KONTROL_TOKEN']).not_to be nil
  end
end

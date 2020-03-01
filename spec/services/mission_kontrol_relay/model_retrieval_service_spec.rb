# frozen_string_literal: true

RSpec.describe MissionKontrolRelay::ModelRetrievalService do
  describe 'build' do
    let(:subject) { described_class.call }

    it 'returns an array of the models' do
      expect(subject.map(&:name)).to match_array %w[Company User Account AccountHistory Appointment Assembly Author Book Part Patient Physician Supplier]
    end
  end
end

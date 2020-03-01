# frozen_string_literal: true

RSpec.describe MissionKontrolRelay::ModelRetrievalService do
  describe 'build' do
    let(:subject) { described_class.build }

    it 'returns an array of the models' do
      expect(subject).to match_array %w[Company User Account AccountHistory Appointment Assembly Author Book Part Patient Physician Supplier]
    end
  end
end

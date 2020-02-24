# frozen_string_literal: true

RSpec.describe MissionKontrolRelay::ValidationMappingService do
  describe 'build' do
    let(:subject) { described_class.new(model).build }

    context 'general' do
      let(:model) { Company }

      it 'returns a hash containing the model name' do
        expect(subject[:model]).to eq 'Company'
      end

      it 'returns an array of columns on the model' do
        expect(subject[:validations]).to be_kind_of Array
      end

    end
  end
end

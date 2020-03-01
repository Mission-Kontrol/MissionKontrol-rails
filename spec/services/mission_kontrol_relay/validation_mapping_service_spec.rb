# frozen_string_literal: true

RSpec.describe MissionKontrolRelay::ValidationMappingService do
  describe 'build' do
    let(:subject) { described_class.new(model).build }
    let(:result) { subject[:validations] }

    context 'general' do
      let(:model) { Company }

      it 'returns a hash containing the model name' do
        expect(subject[:model]).to eq 'Company'
      end

      it 'returns an array of columns on the model' do
        expect(subject[:validations]).to be_kind_of Array
      end
    end

    context 'validation helpers' do
      context 'confirmation' do
        let(:model) { Patient }
        let(:expected_result) {
          {
            attributes: [:email],
            kind: :before,
            name: :validate,
            type: :confirmation
          }
        }

        it 'returns the validation details' do
          confirmation_result = result.select { |validation| validation[:type] == :confirmation }.first
          expect(confirmation_result).to include expected_result
        end
      end

      context 'exclusion' do
        let(:model) { Company }
        let(:expected_result) {
          {
            attributes: [:subdomain],
            kind: :before,
            name: :validate,
            type: :exclusion
          }
        }
        let(:confirmation_result) { result.select { |validation| validation[:type] == :exclusion }.first }

        it 'returns the validation details' do
          expect(confirmation_result).to include expected_result
        end

        it 'returns the exclusion options in the key' do
          expect(confirmation_result[:key].instance_variable_get(:@options)[:in]).to eq %w(www us ca jp)
        end
      end

      context 'format' do
        let(:model) { Part }
        let(:expected_result) {
          {
            attributes: [:legacy_code],
            kind: :before,
            name: :validate,
            type: :format
          }
        }
        let(:confirmation_result) { result.select { |validation| validation[:type] == :format }.first }

        it 'returns the validation details' do
          expect(confirmation_result).to include expected_result
        end

        it 'returns the exclusion options in the key' do
          expect(confirmation_result[:key].instance_variable_get(:@options)[:with]).to eq /\A[a-zA-Z]+\z/
        end
      end

      context 'inclusion' do
        let(:model) { Part }
        let(:expected_result) {
          {
            attributes: [:size],
            kind: :before,
            name: :validate,
            type: :inclusion
          }
        }
        let(:confirmation_result) { result.select { |validation| validation[:type] == :inclusion }.first }

        it 'returns the validation details' do
          expect(confirmation_result).to include expected_result
        end

        it 'returns the exclusion options in the key' do
          expect(confirmation_result[:key].instance_variable_get(:@options)[:in]).to eq %w(small medium large)
        end
      end

      context 'length' do
        let(:model) { User }
        let(:expected_result) {
          {
            attributes: [:name],
            kind: :before,
            name: :validate,
            type: :length
          }
        }
        let(:confirmation_result) { result.select { |validation| validation[:type] == :length }.first }

        it 'returns the validation details' do
          expect(confirmation_result).to include expected_result
        end

        it 'returns the exclusion options in the key' do
          expect(confirmation_result[:key].instance_variable_get(:@options)[:minimum]).to eq 2
        end
      end

      context 'numericality' do
        let(:model) { Assembly }
        let(:expected_result) {
          {
            attributes: [:points],
            kind: :before,
            name: :validate,
            type: :numericality
          }
        }
        let(:confirmation_result) { result.select { |validation| validation[:type] == :numericality }.first }

        it 'returns the validation details' do
          expect(confirmation_result).to include expected_result
        end
      end

      context 'presence' do
        let(:model) { Company }
        
        it 'returns type presence' do
          expect(result.first[:type]).to eq :presence
        end 
      end

      context 'uniqueness' do
        let(:model) { User }
        let(:expected_result) {
          {
            attributes: [:name],
            kind: :before,
            name: :validate,
            type: :uniqueness
          }
        }
        let(:confirmation_result) { result.select { |validation| validation[:type] == :uniqueness }.first }

        it 'returns the validation details' do
          expect(confirmation_result).to include expected_result
        end

        it 'returns the exclusion options in the key' do
          expect(confirmation_result[:key].instance_variable_get(:@options)[:case_sensitive]).to eq true
        end
      end
    end

    context 'custom validations' do
      let(:model) { Company }
      let(:expected_result) {
          {
            attributes: nil,
            kind: :before,
            name: :validate,
            type: nil,
            key: :something
          }
        }
      let(:confirmation_result) { result.select { |validation| validation[:type].nil? }.first }

        
      it 'returns the validation details' do
        expect(confirmation_result).to include expected_result
      end
    end

    context 'conditional validations' do
      let(:model) { Company }
      let(:expected_result) {
          {
            attributes: nil,
            kind: :before,
            name: :validate,
            type: nil,
            key: :something,
            if: [:something_else?]
          }
        }
      let(:confirmation_result) { result.select { |validation| validation[:type].nil? }.first }

        
      it 'returns the validation details' do
        expect(confirmation_result).to include expected_result
      end
    end
  end
end

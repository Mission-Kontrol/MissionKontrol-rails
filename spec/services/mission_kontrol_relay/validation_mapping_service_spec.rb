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
        let(:expected_result) do
          {
            attributes: [:email],
            kind: :before,
            name: :validate,
            type: :confirmation
          }
        end

        it 'returns the validation details' do
          validation_result = result.select { |validation| validation[:type] == :confirmation }.first
          expect(validation_result).to include expected_result
        end
      end

      context 'exclusion' do
        let(:model) { Company }
        let(:expected_result) do
          {
            attributes: [:subdomain],
            kind: :before,
            name: :validate,
            type: :exclusion
          }
        end
        let(:validation_result) { result.select { |validation| validation[:type] == :exclusion }.first }

        it 'returns the validation details' do
          expect(validation_result).to include expected_result
        end

        it 'returns the exclusion options in the key' do
          expect(validation_result[:key].instance_variable_get(:@options)[:in]).to eq %w[www us ca jp]
        end
      end

      context 'format' do
        let(:model) { Part }
        let(:expected_result) do
          {
            attributes: [:legacy_code],
            kind: :before,
            name: :validate,
            type: :format
          }
        end
        let(:validation_result) { result.select { |validation| validation[:type] == :format }.first }

        it 'returns the validation details' do
          expect(validation_result).to include expected_result
        end

        it 'returns the exclusion options in the key' do
          expect(validation_result[:key].instance_variable_get(:@options)[:with]).to eq(/\A[a-zA-Z]+\z/)
        end
      end

      context 'inclusion' do
        let(:model) { Part }
        let(:expected_result) do
          {
            attributes: [:size],
            kind: :before,
            name: :validate,
            type: :inclusion
          }
        end
        let(:validation_result) { result.select { |validation| validation[:type] == :inclusion }.first }

        it 'returns the validation details' do
          expect(validation_result).to include expected_result
        end

        it 'returns the exclusion options in the key' do
          expect(validation_result[:key].instance_variable_get(:@options)[:in]).to eq %w[small medium large]
        end
      end

      context 'length' do
        let(:model) { User }
        let(:expected_result) do
          {
            attributes: [:name],
            kind: :before,
            name: :validate,
            type: :length
          }
        end
        let(:validation_result) { result.select { |validation| validation[:type] == :length }.first }

        it 'returns the validation details' do
          expect(validation_result).to include expected_result
        end

        it 'returns the exclusion options in the key' do
          expect(validation_result[:key].instance_variable_get(:@options)[:minimum]).to eq 2
        end
      end

      context 'numericality' do
        let(:model) { Assembly }
        let(:expected_result) do
          {
            attributes: [:points],
            kind: :before,
            name: :validate,
            type: :numericality
          }
        end
        let(:validation_result) { result.select { |validation| validation[:type] == :numericality }.first }

        it 'returns the validation details' do
          expect(validation_result).to include expected_result
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
        let(:expected_result) do
          {
            attributes: [:name],
            kind: :before,
            name: :validate,
            type: :uniqueness
          }
        end
        let(:validation_result) { result.select { |validation| validation[:type] == :uniqueness }.first }

        it 'returns the validation details' do
          expect(validation_result).to include expected_result
        end

        it 'returns the exclusion options in the key' do
          expect(validation_result[:key].instance_variable_get(:@options)[:case_sensitive]).to eq true
        end
      end
    end

    context 'custom validations' do
      let(:model) { Company }
      let(:expected_result) do
        {
          attributes: nil,
          kind: :before,
          name: :validate,
          type: nil,
          key: :something
        }
      end
      let(:validation_result) { result.select { |validation| validation[:type].nil? }.first }

      it 'returns the validation details' do
        expect(validation_result).to include expected_result
      end
    end

    context 'conditional validations' do
      let(:model) { Company }
      let(:expected_result) do
        {
          attributes: nil,
          kind: :before,
          name: :validate,
          type: nil,
          key: :something,
          if: [:something_else?]
        }
      end
      let(:validation_result) { result.select { |validation| validation[:type].nil? }.first }

      it 'returns the validation details' do
        expect(validation_result).to include expected_result
      end
    end

    context 'key has klass variable' do
      let(:model) { User }
      let(:validation_result) { result.select { |validation| validation[:type] == :uniqueness }.first }

      it 'sets klass to nil' do
        expect(validation_result[:key].instance_variable_get(:@klass)).to eq nil
      end
    end
  end
end

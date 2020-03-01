# frozen_string_literal: true

RSpec.describe MissionKontrolRelay::AssociationMappingService do
  describe 'build' do
    let(:subject) { described_class.new(model).build }

    context 'general' do
      let(:model) { Company }
      let(:expected_result) do
        [
          {
            associated_model: :user,
            options: { foreign_key: 'owner' },
            type: :belongs_to
          }
        ]
      end

      it 'returns a hash containing the model name' do
        expect(subject[:model]).to eq 'Company'
      end

      it 'returns an array of columns on the model' do
        expect(subject[:columns]).to be_kind_of Array
      end

      it 'returns the name on the columns' do
        expect(subject[:columns].first[:column]).to eq 'id'
      end

      it 'returns the sql type on the column' do
        expect(subject[:columns].first[:type]).to eq :integer
      end

      it 'returns an array of associations on the model' do
        expect(subject[:associations]).to be_kind_of Array
      end

      it 'returns all the associations on the model' do
        expect(subject[:associations]).to eq expected_result
      end
    end

    context 'belongs_to' do
      let(:model) { Company }
      let(:result) { subject[:associations].first }

      it 'returns the name of the related model in the association' do
        expect(result[:associated_model]).to eq :user
      end

      context 'foreign_key' do
        it 'returns foreign_key of the related model if not standard' do
          expect(result[:options][:foreign_key]).to eq 'owner'
        end
      end

      it 'returns the type of association' do
        expect(result[:type]).to eq :belongs_to
      end
    end

    context 'has_one' do
      let(:model) { User }
      let(:result) { subject[:associations].first }
      let(:expected_result) do
        [
          {
            associated_model: :company,
            options: {},
            type: :has_one
          }
        ]
      end

      it 'returns the name of the related model in the association' do
        expect(result[:associated_model]).to eq :company
      end

      it 'returns the type of association' do
        expect(result[:type]).to eq :has_one
      end

      it 'returns all the associations on the model' do
        expect(subject[:associations]).to eq expected_result
      end
    end

    context 'has_many' do
      let(:model) { Author }
      let(:expected_result) do
        [
          {
            associated_model: :books,
            options: {},
            type: :has_many
          }
        ]
      end

      it 'returns the name of the related model in the association (pluralised)' do
        expect(subject[:associations].first[:associated_model]).to eq :books
      end

      it 'returns the type of association' do
        expect(subject[:associations].first[:type]).to eq :has_many
      end

      it 'does not return the foreign key' do
        expect(subject[:associations].first[:foreign_key]).to eq nil
      end

      it 'returns all the associations on the model' do
        expect(subject[:associations]).to eq expected_result
      end
    end

    context 'has_many :through' do
      let(:model) { Physician }
      let(:expected_result) do
        [
          {
            associated_model: :appointments,
            options: {},
            type: :has_many
          },
          {
            associated_model: :patients,
            options: { through: :appointments },
            type: :has_many
          }
        ]
      end

      it 'returns the association through in the options' do
        expect(subject[:associations]).to eq expected_result
      end
    end

    context 'has_one :through' do
      let(:model) { Supplier }

      let(:expected_result) do
        [
          {
            associated_model: :account,
            options: {},
            type: :has_one
          },
          {
            associated_model: :account_history,
            options: { through: :account },
            type: :has_one
          }
        ]
      end

      it 'returns the association through in the options' do
        expect(subject[:associations]).to eq expected_result
      end
    end

    context 'has_and_belongs_to_many' do
      let(:model) { Assembly }

      let(:expected_result) do
        [
          {
            associated_model: :parts,
            options: {},
            type: :has_and_belongs_to_many
          }
        ]
      end

      it 'returns the association through in the options' do
        expect(subject[:associations]).to eq expected_result
      end
    end
  end
end

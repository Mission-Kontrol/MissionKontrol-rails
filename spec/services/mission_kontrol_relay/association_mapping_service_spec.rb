# frozen_string_literal: true

RSpec.describe MissionKontrolRelay::AssociationMappingService do
  describe 'build' do
    let(:subject) { described_class.new(model).build }

    context 'general' do
      let(:model) { Company }

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
    end

    context 'belongs_to' do
      let(:model) { Company }
      let(:result) { subject[:associations].first }

      it 'returns the name of the related model in the association' do
        expect(result[:associated_model]).to eq :user
      end

      context 'foreign_key' do
        it 'returns foreign_key of the related model if not standard' do
          expect(result[:foreign_key]).to eq 'owner'
        end
  
        xit 'returns foreign_key of the related model if standard' do
        end
      end
      
      it 'returns the type of association' do
        expect(result[:type]).to eq :belongs_to
      end
    end

    context 'has_one' do
      let(:model) { User }
      let(:result) { subject[:associations].first }

      it 'returns the name of the related model in the association' do
        expect(result[:associated_model]).to eq :company
      end

      context 'foreign_key' do
        xit 'returns foreign_key of the related model if not standard' do
          expect(result[:foreign_key]).to eq nil
        end
  
        xit 'returns foreign_key of the related model if standard' do
        end
      end
      
      it 'returns the type of association' do
        expect(result[:type]).to eq :has_one
      end
    end

    context 'has_many' do
    end

    context 'has_many :through' do
    end

    context 'has_one :through' do
    end

    context 'has_and_belongs_to_many' do
    end
  end
end

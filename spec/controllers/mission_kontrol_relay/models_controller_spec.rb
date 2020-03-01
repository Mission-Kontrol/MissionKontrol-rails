# frozen_string_literal: true

RSpec.describe MissionKontrolRelay::ModelsController do
  routes { MissionKontrolRelay::Engine.routes }

  describe '#associations' do
    let(:subject) { get :associations }

    before do
      allow(MissionKontrolRelay::ModelRetrievalService).to receive(:call).and_return([Company, User])
    end

    it 'returns a json including the model associations' do
      subject
      result = JSON.parse(response.body).first

      expect(result).to have_key('model')
      expect(result).to have_key('columns')
      expect(result).to have_key('associations')
    end
  end

  describe '#validations' do
    let(:subject) { get :validations }

    it 'returns a json including the model validations' do
      subject
      result = JSON.parse(response.body).first

      expect(result).to have_key('model')
      expect(result).to have_key('validations')
    end
  end
end

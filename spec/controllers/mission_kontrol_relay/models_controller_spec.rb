# frozen_string_literal: true

RSpec.describe MissionKontrolRelay::ModelsController do
  routes { MissionKontrolRelay::Engine.routes }

  before do
    ENV['MISSION_KONTROL_TOKEN'] = 'valid'
  end

  after do
    ENV['MISSION_KONTROL_TOKEN'] = nil
  end

  describe '#validate_token' do
    let(:subject) { get :associations, params: params }

    before do
      allow(MissionKontrolRelay::ModelRetrievalService).to receive(:call).and_return([User])
      subject
    end

    context 'when provided token is valid' do
      let(:params) { { token: 'valid' } }

      it 'returns a 200 status' do
        expect(response).to have_http_status(:success)
      end

      it 'returns a json' do
        expect(response.content_type).to eq('application/json')
      end
    end

    context 'when provided token is invalid' do
      let(:params) { { token: 'invalid' } }

      it 'returns a 401 status' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'returns a message stating token is invalid' do
        expect(JSON.parse(response.body)).to eq({ 'error' => 'Invalid token' })
      end
    end

    context 'when token is not provided' do
      let(:params) { {} }

      it 'returns a 401 status' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'returns a message stating a token is required' do
        expect(JSON.parse(response.body)).to eq({ 'error' => 'Please provide a token' })
      end
    end
  end

  describe '#associations' do
    let(:subject) { get :associations, params: { token: 'valid' } }

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
    let(:subject) { get :validations, params: { token: 'valid' } }

    it 'returns a json including the model validations' do
      subject
      result = JSON.parse(response.body).first

      expect(result).to have_key('model')
      expect(result).to have_key('validations')
    end
  end
end

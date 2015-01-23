require 'spec_helper'

describe SecretsController, type: :controller do

  describe 'GET new' do
    it 'returns http success' do
      get 'new'
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end

  describe 'GET create' do
    let(:secret) { double 'secret' }
    let(:data) { { 'data' => 'foo-bar' } }
    before do
      expect(Secret).to receive(:new).with(data).and_return(secret)
    end

    it 'returns http success' do
      allow(secret).to receive(:save).and_return(true)
      post 'create', :secret => data

      expect(response).to be_success
      expect(response.status).to eq(200)
      expect(response).to render_template('link')
    end
  end

  describe 'GET show' do
    let(:secret) { double 'secret', :id => '123456789', 'data' => 'foo-bar' }
    before do
      expect(Secret).to receive(:find).with('123456789').and_return(secret)
    end

    it 'returns http success' do
      get 'show', 'id' => '123456789'
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    context 'with an invalid id' do
      let(:secret) { nil }

      it 'does not exist' do
        get 'show', 'id' => '123456789'
        expect(response).to_not be_success
        expect(response.status).to eq(404)
      end
    end
  end

end

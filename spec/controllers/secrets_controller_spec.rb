require 'spec_helper'

describe SecretsController do

  describe 'GET new' do
    it 'returns http success' do
      get 'new'
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end

  describe 'GET create' do
    let(:secret) { mock 'secret' }
    let(:data) { { 'data' => 'foo-bar' } }
    before do
      Secret.should_receive(:new).with(data).and_return(secret)
    end

    it 'returns http success' do
      secret.stub :save => true
      post 'create', :secret => data

      expect(response).to be_success
      expect(response.status).to eq(200)
      expect(response).to render_template('link')
    end
  end

  describe 'GET show' do
    let(:secret) { stub 'secret', :id => '123456789', 'data' => 'foo-bar' }
    before do
      Secret.should_receive(:find).with('123456789').and_return(secret)
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

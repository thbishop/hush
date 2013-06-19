require 'spec_helper'

describe Secret do
  let(:secret) { Secret.new :data => 'foo-bar' }
  subject { secret }

  describe 'self.find' do
    it 'returns the object' do
      REDIS.should_receive(:get).with('my-id').and_return(secret)
      expect(Secret.find('my-id').data).to eq 'foo-bar'
    end

    context 'the secret does not exist' do
      it 'returns nil' do
        REDIS.should_receive(:get).with('bad').and_return(nil)
        expect(Secret.find 'bad').to be_nil
      end
    end
  end

  describe 'save' do
    let(:response) { 'OK' }

    it 'saves' do
      REDIS.should_receive(:setex).
            with(/\w{10,}/, 600, 'foo-bar').
            and_return(response)
      its(:save) { should be_true }
    end

    context 'when not valid' do
      let(:secret) { Secret.new }
      before { REDIS.should_not_receive :setex }

      its(:save) { should be_false }
    end

  end

  describe 'valid?' do
    it { should be_valid }

    context 'without data' do
      let(:secret) { Secret.new }

      it { should_not be_valid }
    end
  end

end

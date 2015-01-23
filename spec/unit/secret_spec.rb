require 'spec_helper'

describe Secret do
  let(:data) { 'foo-bar' }
  let(:encrypted_data) { 'foo-bar' }
  let(:id) { 'my-id-foo-bar-baz'}
  let(:secret) { Secret.new :data => data, :id => id }
  subject { secret }

  describe 'data' do
    it 'returns encrypted' do
      expect(secret.data).to eq encrypted_data
    end
  end

  describe 'decrypted_data' do
    it 'returns the original and removes the data' do
      secret.data = 'bar-foo'
      expect(REDIS).to receive(:del).with(id)
      expect(Encryptor).to receive(:decrypt).
                           with('bar-foo', key: 'blah').
                           and_return('foo-bar')
      expect(secret.decrypted_data).to eq data
    end
  end

  describe 'self.find' do
    it 'returns the object' do
      expect(REDIS).to receive(:get).with(id).and_return(data)
      expect(Secret.find(id).data).to eq 'foo-bar'
    end

    context 'the secret does not exist' do
      it 'returns nil' do
        expect(REDIS).to receive(:get).with('bad').and_return(nil)
        expect(Secret.find 'bad').to be_nil
      end
    end
  end

  describe 'save' do
    let(:response) { 'OK' }

    it 'saves' do
      expect(Encryptor).to receive(:encrypt).
                           with('foo-bar', key: 'blah').
                           and_return(encrypted_data)
      expect(REDIS).to receive(:setex).
                       with(id, 600, encrypted_data).
                       and_return(response)
      expect(secret.save).to eq(true)
    end

    context 'when not valid' do
      let(:secret) { Secret.new }
      before { expect(REDIS).not_to receive(:setex) }

      it 'should not save' do
        expect(secret.save).to eq(false)
      end
    end

  end

  describe 'valid?' do
    it { should be_valid }

    context 'without data' do
      let(:secret) { Secret.new }

      it 'is not valid' do
        expect(subject).not_to be_valid
      end
    end
  end

end

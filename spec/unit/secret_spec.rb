require 'spec_helper'

describe Secret do
  let(:secret) { Secret.new :data => 'foo-bar' }
  subject { secret }

  describe 'valid?' do
    it { should be_valid }

    context 'without data' do
      let(:secret) { Secret.new }

      it { should_not be_valid }
    end
  end

  describe 'save' do
    let(:response) { 'OK' }

    it 'saves' do
      REDIS.should_receive(:setex).
            with(/\w{10,}/, 600, 'foo-bar').
            and_return(response)
      expect(secret.save).to be_true
    end

    context 'when not valid' do
      let(:secret) { Secret.new }
      before { REDIS.should_not_receive :setex }

      its(:save) { should be_false }
    end

  end

end

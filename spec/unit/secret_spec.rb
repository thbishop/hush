require 'spec_helper'

describe Secret do

  describe 'valid?' do
    let(:secret) { Secret.new :data => 'foo-bar' }
    subject { secret }

    it { should be_valid }

    context 'without data' do
      let(:secret) { Secret.new }

      it { should_not be_valid }
    end
  end

end

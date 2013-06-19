require 'spec_helper'

describe Secret do

  describe 'valid?' do
    let(:secret) { Secret.new }
    subject { secret }

    it { should_not be_valid }

    context 'with data' do
      before { subject.data = 'foo-bar' }
      it { should be_valid }
    end

  end

end

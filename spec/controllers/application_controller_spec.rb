
require 'spec_helper'

describe ApplicationController, type: :controller do

  describe 'block_slackbot_link_expander' do
    it 'blocks request from the Slackbot link expander user agent' do
      allow(controller.request).to receive(:user_agent).and_return('Slackbot-LinkExpanding 1.0 (+https://api.slack.com/robots)')
      expect(controller).to receive(:head).with(403)
      controller.block_slackbot_link_expander
    end

    it 'allows requests that are not from the Slackbot link expander' do
      allow(controller.request).to receive(:user_agent).and_return('Some other user agent')
      expect(controller).not_to receive(:head).with(403)
      controller.block_slackbot_link_expander
    end

    it 'allows requests where user agent is nil' do
      allow(controller.request).to receive(:user_agent).and_return(nil)
      expect(controller).not_to receive(:head).with(403)
      controller.block_slackbot_link_expander
    end
  end

end

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :block_slackbot_link_expander

  def block_slackbot_link_expander
    if request.user_agent.present? && request.user_agent.starts_with?('Slackbot-LinkExpanding')
      head(403)
    end
  end
end

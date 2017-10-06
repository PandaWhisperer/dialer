class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_mailer_host

  # Just default to first user to avoid having to deal with login
  def current_user
    User.first
  end

  private

  def set_mailer_host
    puts "AC: Action Mailer settings: #{ActionMailer::Base.default_url_options}"
    puts "AC: Setting mailer host to #{request.host_with_port}"
    ActionMailer::Base.default_url_options = { :host => request.host_with_port }
  end
end

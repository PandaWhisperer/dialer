class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def call
    puts "UC: Action Mailer settings: #{ActionMailer::Base.default_url_options}"
    @user = User.find(params[:id])
    @call = Call.create(from_user: current_user, to_user: @user)

    redirect_to @call, notice: 'Call in progress. Please wait...'
  end

  private

  def current_user
    User.first
  end
end

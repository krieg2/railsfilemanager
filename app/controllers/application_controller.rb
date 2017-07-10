class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private
  def current_user
    UserAccount.where(id: session[:user_account_id]).first
  end
  helper_method :current_user
end

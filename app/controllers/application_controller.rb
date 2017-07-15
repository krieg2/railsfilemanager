class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    UserAccount.where(id: session[:user_account_id]).first
  end
  helper_method :current_user

  def authorize
    redirect_to root_path unless current_user
  end

end

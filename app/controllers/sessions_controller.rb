class SessionsController < ApplicationController

  def new
  end

  def create
    @user = UserAccount.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_account_id] = @user.id
      redirect_to user_account_uploaded_files_path(@user), notice: 'Logged in.'
    else
      flash.now[:notice] = 'User account not found.'
      render :new
    end
  end

  def destroy
    session[:user_account_id] = nil
    redirect_to root_path, notice: 'Logged out.'
  end
end

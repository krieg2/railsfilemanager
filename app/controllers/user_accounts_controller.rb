class UserAccountsController < ApplicationController
  def index
    @user_accounts = UserAccount.order('firstname').all
  end

  def new
    @user_account = UserAccount.new
  end

  def create
    @user_account = UserAccount.new(user_account_params)

    if @user_account.save

      session[:user_account_id] = @user_account.id
      redirect_to user_account_uploaded_files_path(@user_account)
    else

      render :new
    end
  end

  def edit
    id = params[:id]
    @user_account = UserAccount.find(id)
  end

  def update
    id = params[:id]
    @user_account = UserAccount.find(id)
    if @user_account.update(user_account_params)

      redirect_to user_account_uploaded_files_path(@user_account)
    else
      
      render 'edit'
    end
  end

  private
  def user_account_params
    params.require(:user_account).permit(:firstname, :lastname, :email, :password)
  end
end

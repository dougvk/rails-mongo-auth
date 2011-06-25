class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @title = @user.email
  end
  
  def new
    @user = User.new
    @title = "Sign up"
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to MetaPAC!"
      redirect_to @user
    else
      @title = "Sign up"
      @user.password = @user.password_confirmation = ""
      render 'new'
    end
  end
  
  private
  
    def authenticate
      deny_access unless signed_in?
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless correct_user? (@user)
    end
end

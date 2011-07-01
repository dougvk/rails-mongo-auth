require 'open-uri'

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

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if not url_exists 
      params[:user][:url] = nil
    elsif @user.url.eql? params[:user][:url]
      # do nothing if same url
    else
      # runs the tag creation as background process so it
      # doesn't hold up the redirect
      if not @user.url.nil?
        call_rake :delete_tag_associations, :user_id => params[:id]
      end
      call_rake :create_tag_associations, :user_id => params[:id], :user_url => params[:user][:url]
    end
    @user.set(params[:user])
    redirect_to @user
  end
  
  private
  
    def authenticate
      deny_access unless signed_in?
    end
    
    def url_exists
      begin
        open(params[:user][:url])
      rescue
        return false
      end
      return true
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless correct_user? (@user)
    end
end

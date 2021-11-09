class LoginController < ApplicationController
  def index
    @current_user = current_user
  end
  def login_new;user = User.new;end
  def register_new;user = User.new;end
  def create
    user = User.find_by(name: params[:name])
    unless user.nil?
      if user && user.authenticate(params[:password])
        log_in user
        redirect_to main_page_path
      else
        render 'login_new'
      end
    else
      render 'login_new'
    end
  end
  def destroy
    log_out
    redirect_to root_path
  end
  def register
    user = User.new(:name=>params[:name],:password=>params[:password])
    @user_find = User.find_by(name: params[:name])
    unless @user_find.nil?
      user.save
      log_in user
      redirect_to main_page_path
    else
      render 'register_new'
    end
  end
end

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
    @random_number = rand(1000..9999) 
    user = User.new(:employee_id=>@random_number,
                    :name=>params[:name],
                    :password=>params[:password],
                    :department=>params[:department],
                    :hire_date=>DateTime.now,
                    :employee_type=>params[:employee_type])
    @user_find = User.find_by(name: params[:name])
    if @user_find.nil? #ถ้าไม่เจอชื่อซ้ำใน database
      user.save
      redirect_to login_path
    else
      render 'register_new'
    end
  end
end

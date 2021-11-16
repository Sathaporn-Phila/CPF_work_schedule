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
    @user_find = User.find_by(name: params[:name])
    if @user_find.nil? #ถ้าไม่เจอชื่อซ้ำใน database
      user = User.create!(:employee_id=>@random_number,
        :title_name=>params[:title_name],
        :name=>params[:name],
        :password=>params[:password],
        :factory=>params[:factory],
        :department=>params[:department],
        :hire_date=>DateTime.now,
        :employee_income_type=>params[:employee_income_type],
        :role=>params[:role])
      redirect_to login_path
    else
      render 'register_new'
    end
    
  end
end

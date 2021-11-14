class DashboardController < ApplicationController
    def index
        @current_user = current_user
        @actual_time = ScheduleActualTime.all
    end
    def register_new;user = User.new;end
    def destroy
        log_out
        redirect_to root_path
    end

    def check_timestamp
        @lat_lng = cookies[:lat_lng]
        if ScheduleActualTime.all.where(user_id: current_user.id).length == 0
            @time_object = ScheduleActualTime.create(
                :time_in=>DateTime.now()
            )
            current_user.schedule_actual_times << @time_object
            ActionCable.server.broadcast(
                'actual_time_channel',{
                name: current_user.name,
                time_in: @time_object.time_in.strftime("%H:%M:%S"),
                time_out:"-"
                }
            )
        else 
            @time_object = ScheduleActualTime.find_by(user_id: current_user.id).update(
                :time_out=>DateTime.now()
            )
            ActionCable.server.broadcast(
                'actual_time_channel',{
                name: current_user.name,
                time_in: ScheduleActualTime.find_by(user_id: current_user.id).time_in.strftime("%H:%M:%S"),
                time_out: ScheduleActualTime.find_by(user_id: current_user.id).time_out.strftime("%H:%M:%S")
                }
            )
        end 
        
        redirect_to main_page_path
    end

    def register
        @random_number = rand(1000..9999) 
        @user_find = User.find_by(name: params[:name])
        if @user_find.nil? #ถ้าไม่เจอชื่อซ้ำใน database
            user = User.create!(:employee_id=>random_num,
                :title_name=>params[:title_name],
                :name=>params[:name],
                :password=>params[:password],
                :factory=>params[:factory],
                :department=>params[:department],
                :hire_date=>DateTime.now,
                :employee_income_type=>params[:employee_income_type],
                :role=>params[:role])
            redirect_to main_page_path
        else
          render 'register_user'
        end
        
    end

    
end

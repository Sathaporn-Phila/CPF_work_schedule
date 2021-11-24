class DashboardController < ApplicationController
    def index
        @current_user = current_user
        @actual_time = ScheduleActualTime.all
        @history = History.all
        @plantime = SchedulePlantime.all
        @shift_code = Shiftcode.all
    end
    def register_new;
        user = User.new;
        @plan_time = SchedulePlantime.new
        @shift_code = Shiftcode.all
    end
    def destroy
        log_out
        redirect_to root_path
    end

    def check_timestamp
        @lat_lng = cookies[:lat_lng]
        if ScheduleActualTime.all.where(user_id: current_user.id).length == 0
            puts current_user
            if current_user.role == "คนงานทั่วไป" 
                @time_object = ScheduleActualTime.create(
                    :time_in=>DateTime.now(),
                    :code_name=>current_user.shiftcodes.last.code_name,
                    :department_name=>current_user.department,
                    :factory=>current_user.factory
                )
            else
                @time_object = ScheduleActualTime.create(
                    :time_in=>DateTime.now(),
                    :department_name=>current_user.department,
                    :factory=>current_user.factory
                )
            end
            current_user.schedule_actual_times << @time_object
            @time_object1 = History.create(
                :user_id => current_user.id,
                :time_in=>DateTime.now(),
                :department_name=>current_user.department,
                :factory=>current_user.factory

            )
            current_user.schedule_actual_times << @time_object
            current_user.histories << @time_object1
            if current_user.role == "คนงานทั่วไป"
                ActionCable.server.broadcast(
                    'actual_time_channelschedule_room',{
                    name: current_user.name,
                    time_in: @time_object.time_in.strftime("%H:%M:%S"),
                    time_out:"-",
                    shift_code:current_user.shiftcodes.last.code_name,
                    department: current_user.department,
                    factory:current_user.factory,
                    role: current_user.role,
                    ot_time: "#",
                    act: "show"
                    }
                )
            end
        else 
            @time_object = ScheduleActualTime.find_by(user_id: current_user.id)
            if User.find_by(id: current_user.id).shiftcodes.length > 0
                @shiftcode_time_out = User.find_by(id: current_user.id).shiftcodes.last.end_in
                @actual_ot = Time.at((Time.now() - ((Time.now().hour - @shiftcode_time_out.hour).hours + (Time.now().min - @shiftcode_time_out.min).minute).ago)).utc.strftime("%H:%M:%S")
                ActionCable.server.broadcast(
                'actual_time_channelschedule_room',{
                name: current_user.name,
                time_in: ScheduleActualTime.find_by(user_id: current_user.id).time_in.strftime("%H:%M:%S"),
                time_out: DateTime.now().strftime("%H:%M:%S"),
                factory:current_user.factory,
                shift_code:current_user.shiftcodes.last.code_name,
                department: current_user.department,
                role: current_user.role,
                ot_time:@actual_ot,
                act: "delete"}
                )
                @time_object.destroy
                @time_object1 = current_user.histories.last.update(
                    {:ot_time=>@actual_ot,:time_out=>DateTime.now()}
                )
            else
                @time_object.destroy
                unless History.find_by(user_id: current_user.id).nil?
                    @time_object1 = History.find_by(user_id: current_user.id).update(
                        :time_out=>DateTime.now()
                    )
                else
                    @time_object1 = History.create(
                        :user_id => current_user.id,
                        :time_in=>DateTime.now()
                    )
                    current_user.histories << @time_object1
                end
            end
            
        end 
        redirect_to main_page_path
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
            @new_shift_code = Shiftcode.find_by(code_name:params[:shift_code_select])
            user.shiftcodes << @new_shift_code.dup
            redirect_to main_page_path
        else
          render 'register_user'
        end        
    end
    def get_num_person_shiftcode
        @num_person = ScheduleActualTime.where(factory:params['factory'],department_name:params['department'],code_name:params['code_name']).length
        respond_to do |format|
            msg = { :status => "ok", :message => @num_person}
            format.json  { render :json => msg }
        end
    end
end

class ManageUserController < ApplicationController
    def index
        @current_user = current_user
        @actual_time = ScheduleActualTime.all
    end
    def set_plan
        @plan_all = params["ot_time_select"]
        @plan_all.each do|item|
            time = item[0]
            id_user = item[1]
            user = User.find(id_user)
            shiftcode = user.shiftcodes.first
            if shiftcode.time_in > time.to_time #plan ก่อนเวลาเข้างาน
                @new_plan_time = ScheduleActualTime.create(department:user.department,time_in:shiftcode.time_in,time_out:shift_code.time_out+shift_code.ot_time,ot_time:shiftcode.ot_time)

            else
                @new_plan_time = ScheduleActualTime.create(department:user.department,time_in:shiftcode.time_in+1.days,time_out:shift_code.time_out+shift_code.ot_time+1.days,ot_time:shiftcode.ot_time+1.days)
            user.schedule_actual_times << @new_plan_time 
        redirect_to manage_user_path
    end
end

class ManageUserController < ApplicationController
    def index
        @current_user = current_user
        @actual_time = ScheduleActualTime.all
    end
    def manage_worker
        self.set_plan(params["ot_time_select"])
    end
    def set_plan(plan_all)
        plan_all.each do |item|
            item = create_array_from_object(item)
            @ot_time = item[0]
            @id_user = item[1]
            user = User.find(@id_user)
            
            shifttime = user.shiftcodes.first
            @ot_time = Time.parse(@ot_time)
            new_shift_time = DateTime.now().change(hour:shifttime.start_in.hour,min:shifttime.start_in.min)
            if  DateTime.now() < new_shift_time#plan ก่อนเวลาเข้างาน
                @new_plan_time = SchedulePlantime.create(shift_code:shifttime.code_name,time_in:new_shift_time,time_out:new_shift_time+@ot_time.hour.to_i.hours+9.hours+@ot_time.min.to_i.minute,ot_time:@ot_time..hour+@ot_time.min/60)
            else#plan หลังเข้างาน
                @new_plan_time = SchedulePlantime.create(shift_code:shifttime.code_name,time_in:new_shift_time+1.days,time_out:new_shift_time+@ot_time.hour.to_i.hours+1.days+9.hours+@ot_time.min.to_i.minute,ot_time:@ot_time.hour+@ot_time.min/60)
            end
            user.schedule_plantimes << @new_plan_time
        end
        #redirect_to manage_user_path
    end
    def create_array_from_object(array_string)
        item = array_string.split(",")
        for value in item do
            if value.include? "["
                some_item = value[1..value.length-1]
            elsif value.include? "]"
                @id_user = value[0..value.length-2]
            end
        end
        return [some_item,@id_user]
    end
end

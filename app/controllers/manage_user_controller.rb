class ManageUserController < ApplicationController
    def index
        @current_user = current_user
        @actual_time = ScheduleActualTime.all
    end
    def manage_worker
        if params[:commit] == "ยืนยัน"
            unless params["ot_time_select"].nil?
                self.set_plan(params["ot_time_select"])
            end
            unless params['department_select'].nil?
                self.set_department(params['department_select'])
            end
        else
            self.update_ot
        end
        redirect_to manage_user_path
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
                @new_plan_time = SchedulePlantime.create(shift_code:shifttime.code_name,time_in:new_shift_time,time_out:new_shift_time+9.hours,ot_time:@ot_time,factory_name:user.factory,department_name:user.department)
            else#plan หลังเข้างาน
                @new_plan_time = SchedulePlantime.create(shift_code:shifttime.code_name,time_in:new_shift_time+1.days,time_out:new_shift_time+1.days+9.hours,ot_time:@ot_time,factory_name:user.factory,department_name:user.department)
            end
            user.schedule_plantimes << @new_plan_time
        end
    end

    def set_department(department_all)
        department_all.each do |department_each|
            department_each = create_array_from_object(department_each)
            @department_plan = department_each[0].delete('\\"')
            @id_user_d = department_each[1]
            @user = User.find(@id_user_d)
            unless (@user.department == @department_plan) || @department_plan.nil?
                User.find(@id_user_d).update(department: @department_plan)
                User.find(@id_user_d).schedule_actual_times.last.update(department_name:@department_plan)
                User.find(@id_user_d).histories.last.update(department_name:@department_plan)
            end
        end
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
    def update_ot
        @ot_who_update = params["ot_time_select"]
        unless @ot_who_update.nil?
            @ot_who_update.each do |item|
                item = create_array_from_object(item)
                @ot_time = item[0]
                @id_user = item[1]
                @ot_time = Time.parse(@ot_time)
                user = User.find(@id_user)
                if user.schedule_plantimes.length > 0
                    user.schedule_plantimes.last.update(ot_time:@ot_time)
                end
            end
        end
        redirect_to manage_user_path 
    end
end

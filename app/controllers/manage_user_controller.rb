class ManageUserController < ApplicationController
    def index
        @current_user = current_user
        @actual_time = ScheduleActualTime.all
    end
    def set_plan
        @plan_all = params
        puts @plan_all
    end
end

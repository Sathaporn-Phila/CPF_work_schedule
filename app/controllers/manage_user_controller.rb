class ManageUserController < ApplicationController
    def index
        @current_user = current_user
        @actual_time = ScheduleActualTime.all
    end
end

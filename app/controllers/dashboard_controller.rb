class DashboardController < ApplicationController
    def index
        @current_user = current_user
    end
    def destroy
        log_out
        redirect_to root_path
    end
    def check_timestamp
        @time_object = ScheduleActualTime.create(
            :global_position=>params[:position],
            :type_attendance=>"Check in",
            :time_attendance=>DateTime.now()
        )
        current_user.schedule_actual_times << @time_object
        redirect_to main_page_path
    end
end

class DashboardController < ApplicationController
    def index
        @current_user = current_user
        @actual_time = ScheduleActualTime.all
    end
    def destroy
        log_out
        redirect_to root_path
    end
    def check_timestamp
        @lat_lng = cookies[:lat_lng]
        @time_object = ScheduleActualTime.create(
            :global_position=>@lat_lng,
            :type_attendance=>"Check in",
            :time_attendance=>DateTime.now()
        )
        current_user.schedule_actual_times << @time_object
        redirect_to main_page_path
    end
end

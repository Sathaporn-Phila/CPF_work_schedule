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
            :time_in=>DateTime.now()
        )
        current_user.schedule_actual_times << @time_object
        ActionCable.server.broadcast(
            'actual_time_channel',{
            name: current_user.name,
            time_in: @time_object.time_in
            }
         )
        
        redirect_to main_page_path
    end
end

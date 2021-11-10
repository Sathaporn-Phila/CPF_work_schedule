class DashboardController < ApplicationController
    def index
        @current_user = current_user
    end
    def destroy
        log_out
        redirect_to root_path
    end
    def check_timestamp
        @timestamp = DateTime.now();
        logger.debug @timestamp
        redirect_to main_page_path
    end
end

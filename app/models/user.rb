class User < ApplicationRecord
    has_secure_password
    has_many :schedule_actual_times 
end

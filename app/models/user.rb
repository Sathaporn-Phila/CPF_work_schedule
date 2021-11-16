class User < ApplicationRecord
    has_secure_password
    has_many :schedule_actual_times
    has_many :schedule_plantimes
    has_many :shiftcodes
    # has_many :sector, through: :schedule_actual_times
    has_many :histories
end

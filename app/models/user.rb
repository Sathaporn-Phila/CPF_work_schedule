class User < ApplicationRecord
    has_secure_password
    has_many :schedule_actual_times
    has_many :schedule_plantimes
    # has_many :sector, through: :schedule_actual_times
    belongs_to :sector, optional: true
end

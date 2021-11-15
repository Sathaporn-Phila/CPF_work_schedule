class History < ApplicationRecord
    belongs_to :users,:optional => true
end

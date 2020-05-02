class UserLift < ActiveRecord::Base
    belongs_to :user
    belongs_to :lift_type
end
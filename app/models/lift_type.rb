class LiftType < ActiveRecord::Base
    has_many :user_lifts
    has_many :users, :through => :user_lifts
end
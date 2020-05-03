
class User < ActiveRecord::Base
    has_secure_password
    has_many :user_lifts
    has_many :lift_types, :through => :user_lifts
    validates :username, presence: => true
    validates :password, presence: => true
    include Slugifiable::InstanceMethods
    extend Slugifiable::ClassMethods
end

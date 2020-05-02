
class User < ActiveRecord::Base
    has_secure_password
    has_many :user_lifts
    has_many :lift_types, :through => :user_lifts
    include Slugifiable::InstanceMethods
    extend Slugifiable::ClassMethods
end

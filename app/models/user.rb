
class User < ActiveRecord::Base
    has_secure_password
    has_many :user_lifts
    has_many :lift_types, :through => :user_lifts
    validates_uniqueness_of :username
    # validates_presence_of :username
    # validates_presence_of :password
    include Slugifiable::InstanceMethods
    extend Slugifiable::ClassMethods
end

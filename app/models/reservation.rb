class Reservation < ActiveRecord::Base
    has_secure_password

    belongs_to :user
end
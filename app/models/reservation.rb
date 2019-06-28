class Reservation < ActiveRecord::Base
    belongs_to :user

    validates :resource, :uniqueness => {:scope => :date}
end
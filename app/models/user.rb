class User < ActiveRecord::Base
    has_secure_password

    has_many :reservations

    def slug
        name = self.username.downcase
        split_name = name.split(" ")
        slug_name = split_name.join("-")
        slug_name
      end
      
    def self.find_by_slug(slug)
        split_slug = slug.split("-")
        deslugified_name = split_slug.each_with_index.map{|word| word}.join(" ")
        self.find_by(username: deslugified_name)
    end
end
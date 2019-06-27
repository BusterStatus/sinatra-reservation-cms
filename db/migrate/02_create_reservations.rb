class CreateReservations < ActiveRecord::Migration
    def change
        create_table :reservations do |t|
            t.string :name
            t.datetime :date
            t.string :resource
            t.string :contact
            t.integer :user_id
        end
    end
end
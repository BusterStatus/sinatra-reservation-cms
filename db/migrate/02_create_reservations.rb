class CreateReservations < ActiveRecord::Migration
    def change
        create_table :reservations do |t|
            t.string :name
            t.datetime :date
            t.string :resource
            t.string :contact
        end
    end
end
class CreateEvents < ActiveRecord::Migration[4.2]
    def change
      create_table :events do |t|
        t.string :name
        t.string :location
        t.datetime :date
        t.integer :user_id
      end
    end
  end
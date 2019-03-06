class CreateAttenders < ActiveRecord::Migration[4.2]
    def change
      create_table :attenders do |t|
        t.string :name
        t.boolean :rsvp, default: false
        t.integer :event_id
      end
    end
  end
class CreateContractors < ActiveRecord::Migration[4.2]
    def change
      create_table :contractors do |t|
        t.string :name
        t.integer :cost
        t.integer :event_id
        t.string :title
      end
    end
  end
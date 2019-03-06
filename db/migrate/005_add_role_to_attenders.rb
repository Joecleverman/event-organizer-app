class AddRoleToAttenders < ActiveRecord::Migration[4.2]
    def change
      add_column :attenders, :role, :string, default: "None"
    end
  end
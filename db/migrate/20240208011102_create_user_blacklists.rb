class CreateUserBlacklists < ActiveRecord::Migration[5.2]
  def change
    create_table :user_blacklists do |t|
      t.integer :userid
      t.string :reason
      t.integer :level

      t.timestamps
    end
  end
end

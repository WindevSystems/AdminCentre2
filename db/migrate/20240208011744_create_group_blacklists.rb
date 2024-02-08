class CreateGroupBlacklists < ActiveRecord::Migration[5.2]
  def change
    create_table :group_blacklists do |t|
      t.integer :groupid
      t.integer :rankid
      t.string :reason
      t.integer :level

      t.timestamps
    end
    add_index :user_blacklists, :userid, unique: true
  end
end

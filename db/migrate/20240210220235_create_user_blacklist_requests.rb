class CreateUserBlacklistRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :user_blacklist_requests do |t|
      t.integer :targetuserid, null: false
      t.integer :suggestedlevel, null: false
      t.string :reason, null: false
      t.string :evidence, null: false
      t.integer :requesterid, null: false

      t.timestamps
    end

    add_index :user_blacklist_requests, :targetuserid, unique: true
  end
end

class CreateIpBans < ActiveRecord::Migration[5.2]
  def change
    create_table :ip_bans do |t|
      t.string :ip
      t.string :reason
      t.string :actioneremail
      t.string :incidentid
      t.timestamp :until
      t.timestamp :appealabledate
      t.boolean :appealable, default: true

      t.timestamps
    end

    add_index :ip_bans, :ip, unique: true
  end
end

# frozen_string_literal: true

class DeviseCreateAdmins < ActiveRecord::Migration[5.2]
  def change
    create_table :admins do |t|
      t.string :email, null: false
      t.string :full_name
      t.string :uid
      t.string :avatar_url
      t.boolean :superadmin, default: false
      t.boolean :admin, default: false
      t.boolean :lesseradmin, default: false
      t.boolean :support, default: true
      t.boolean :disabled, default: false

      t.timestamps null: false
    end

    add_index :admins, :email, unique: true
  end
end

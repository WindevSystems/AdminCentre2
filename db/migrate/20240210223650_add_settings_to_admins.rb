class AddSettingsToAdmins < ActiveRecord::Migration[5.2]
  def change
    # 0 is default, 1 is dark, 2 is light
    add_column :admins, :theme, :integer, null: false, default: 0
  end
end

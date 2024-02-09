class AddBioToAdmins < ActiveRecord::Migration[5.2]
  def change
    add_column :admins, :bio, :string, :limit => 400, :default => "No user bio set"
  end
end

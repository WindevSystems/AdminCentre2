class RedoLicensingSchema < ActiveRecord::Migration[5.2]
  def change
    # Remove the old columns
    remove_column :licenses, :products, :json
    remove_column :licenses, :suspendedproducts, :json

    # Add new colums that make it easier to query the database from the controller
    # 0 = no license, 1 = active license, 2 = suspended license
    add_column :licenses, :kgc_license, :integer, default: 0
    add_column :licenses, :timeclock_license, :integer, default: 0
  end
end

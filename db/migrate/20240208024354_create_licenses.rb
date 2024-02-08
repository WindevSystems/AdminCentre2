class CreateLicenses < ActiveRecord::Migration[5.2]
  def change
    create_table :licenses do |t|
      t.integer :userid
      t.json :products
      t.json :suspendedproducts

      t.timestamps
    end
    add_index :licenses, :userid, unique: true
  end
end

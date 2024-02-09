class AddCommentToLicenses < ActiveRecord::Migration[5.2]
  def change
    add_column :licenses, :comment, :string
  end
end

class AddStatusToUserBlacklistRequests < ActiveRecord::Migration[5.2]
  # despite the migration name we are reduxing the table to give requesters and admins more info
  def change
    # 0 = pending investigation, 1 = under review, 2 = accepted as is, 3 = accepted with slight modification, 4 = rejected
    add_column :user_blacklist_requests, :status, :integer, null: false, default: 0
    add_column :user_blacklist_requests, :claimeremail, :string, default: nil
    add_column :user_blacklist_requests, :claimed, :boolean, default: false
    add_column :user_blacklist_requests, :licenserevocneeded, :boolean, default: false
    add_column :user_blacklist_requests, :completed, :boolean, default: false

    remove_column :user_blacklist_requests, :requesterid
    add_column :user_blacklist_requests, :requesteremail, :string, null: false, default: "looking thru glass eyes, give it a few tries"
  end
end

namespace :crontasks do
  desc "Run all daily cron tasks."
  task daily: :environment do
    IpBan.delete_expired
    IpBan.make_appealable
  end

  desc "Remove all expired IP bans."
  task remove_expired_bans: :environment do
    IpBan.delete_expired
  end

  desc "Make all appealable IP bans appealable."
  task make_appealable: :environment do
    IpBan.make_appealable
  end
end

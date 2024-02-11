# AC2 cron file.
every 1.day, at: '12:00 am' do
  runner "IpBan.delete_expired"
  runner "IpBan.make_appealable"
end

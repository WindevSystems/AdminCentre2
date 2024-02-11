namespace :setup do
  desc "Ban an IP."
  task ban: :environment do
    puts "Enter an IP address to ban."
    ip = STDIN.gets.chomp
    puts "Enter a reason for the ban."
    reason = STDIN.gets.chomp
    puts "Enter the email address of the person who banned the IP."
    actioneremail = STDIN.gets.chomp
    puts "Enter the incident ID of the ban."
    incidentid = STDIN.gets.chomp
    puts "Enter the date and time the ban will expire. (YYYY-MM-DD HH:MM:SS)"
    untildate = STDIN.gets.chomp
    IpBan.create(ip: ip, reason: reason, actioneremail: "Banned with rake task", incidentid: incidentid, until: untildate, appealabledate: nil, appealable: true)
    puts "IP ban created."
  end
  desc "Unban an IP."
  task unban: :environment do
    puts "Enter an IP address to unban."
    ip = STDIN.gets.chomp
    if IpBan.find_by(ip: ip).nil?
      puts "IP not found."
      return
    end
    rempending = IpBan.find_by(ip: ip)
    puts "#{rempending.ip} is banned until #{rempending.until}."
    puts "Actioner: #{rempending.actioneremail}, Incident ID: #{rempending.incidentid}"
    puts "Reason: #{rempending.reason}"
    puts "Appealable: #{rempending.appealable} until #{rempending.appealabledate}."
    puts "Are you sure you want to unban this IP? (yes/no)"
    confirm = STDIN.gets.chomp
    if confirm != "yes"
      puts "IP ban removal cancelled."
      return
    end
    puts "IP ban removed."
  end
  desc "Get information about an IP ban."
  task getinfo: :environment do
    puts "Enter an IP address to get information about."
    ip = STDIN.gets.chomp
    if IpBan.find_by(ip: ip).nil?
      puts "IP not found."
      return
    end
    rempending = IpBan.find_by(ip: ip)
    puts "#{rempending.ip} is banned until #{rempending.until}."
    puts "Actioner: #{rempending.actioneremail}, Incident ID: #{rempending.incidentid}"
    puts "Reason: #{rempending.reason}"
    puts "Appealable: #{rempending.appealable} until #{rempending.appealabledate}."
  end
  desc "List all IP bans."
  task list: :environment do
    puts "Listing all IP bans."
    IpBan.all.each do |ban|
      puts "#{ban.ip} is banned until #{ban.until}."
      puts "Actioner: #{ban.actioneremail}, Incident ID: #{ban.incidentid}"
      puts "Reason: #{ban.reason}"
      puts "Appealable: #{ban.appealable} until #{ban.appealabledate}."
      puts "-----------------"
    end
  end
end

namespace :usermgmt do
  desc "Grant a user superadmin privileges"
  task superadmin: :environment do
    puts "Enter the user's email address: "
    email = STDIN.gets.chomp
    user = Admin.find_by(email: email)
    if user.nil?
      puts "User not found."
      return
    end
    user.update_attribute(:superadmin, true)
    user.update_attribute(:admin, false)
    user.update_attribute(:lesseradmin, false)
    user.update_attribute(:support, false)
    puts "User #{email} is now a superadmin."
  end
  desc "Grant a user admin privileges"
  task admin: :environment do
    puts "Enter the user's email address: "
    email = STDIN.gets.chomp
    user = Admin.find_by(email: email)
    if user.nil?
      puts "User not found."
      return
    end
    user.update_attribute(:superadmin, false)
    user.update_attribute(:admin, true)
    user.update_attribute(:lesseradmin, false)
    user.update_attribute(:support, false)
    puts "User #{email} is now an admin."
  end
  desc "Grant a user lesseradmin privileges"
  task lesseradmin: :environment do
    puts "Enter the user's email address: "
    email = STDIN.gets.chomp
    user = Admin.find_by(email: email)
    if user.nil?
      puts "User not found."
      return
    end
    user.update_attribute(:superadmin, false)
    user.update_attribute(:admin, false)
    user.update_attribute(:lesseradmin, true)
    user.update_attribute(:support, false)
    puts "User #{email} is now a lesseradmin."
  end
  desc "Grant a user support privileges"
  task support: :environment do
    puts "Enter the user's email address: "
    email = STDIN.gets.chomp
    user = Admin.find_by(email: email)
    if user.nil?
      puts "User not found."
      return
    end
    user.update_attribute(:superadmin, false)
    user.update_attribute(:admin, false)
    user.update_attribute(:lesseradmin, false)
    user.update_attribute(:support, true)
    puts "User #{email} is now a support user."
  end
  desc "Disable a user"
  task disable: :environment do
    puts "Enter the user's email address: "
    email = STDIN.gets.chomp
    user = Admin.find_by(email: email)
    if user.nil?
      puts "User not found."
      return
    end
    user.update_attribute(:superadmin, false)
    user.update_attribute(:admin, false)
    user.update_attribute(:lesseradmin, false)
    user.update_attribute(:support, false)
    user.update_attribute(:disabled, true)
    puts "User #{email} is now disabled."
  end
  desc "Enable a user"
  task enable: :environment do
    puts "This will reset user permissions to default. Continue? (y/n)"
    confirm = STDIN.gets.chomp
    if confirm != "y"
      puts "Aborting."
      return
    end
    puts "Enter the user's email address: "
    email = STDIN.gets.chomp
    user = Admin.find_by(email: email)
    if user.nil?
      puts "User not found."
      return
    end
    user.update_attribute(:superadmin, false)
    user.update_attribute(:admin, false)
    user.update_attribute(:lesseradmin, false)
    user.update_attribute(:support, true)
    user.update_attribute(:disabled, false)
    puts "User #{email} is now enabled."
  end
  desc "List all users"
  task list: :environment do
    Admin.all.each do |user|
      puts "#{user.full_name} <#{user.email}> (superadmin: #{user.superadmin}, admin: #{user.admin}, lesseradmin: #{user.lesseradmin}, support: #{user.support}, disabled: #{user.disabled})"
    end
  end
  desc "Delete a user"
  task delete: :environment do
    puts "This will permanently delete the user. Continue? (y/n)"
    confirm = STDIN.gets.chomp
    if confirm != "y"
      puts "Aborting."
      return
    end
    puts "Enter the user's email address: "
    email = STDIN.gets.chomp
    user = Admin.find_by(email: email)
    if user.nil?
      puts "User not found."
      return
    end
    user.destroy
    puts "User #{email} has been deleted."
  end
end

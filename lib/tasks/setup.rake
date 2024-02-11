namespace :setup do
  desc "Generate an API token."
  task apitoken: :environment do
    require 'securerandom'
    require 'bcrypt'
    # first, generate a random token.
    token = SecureRandom.base64(32)
    # then, hash it.
    hashed_token = BCrypt::Password.create(token)
    puts "Generated token: #{hashed_token}"
    puts "Set the HUB_API_TOKEN environment variable to the above value in your .env file."
  end
end

class Admin < ApplicationRecord
  devise :ldap_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:username]

  # ldap


  def self.from_google(email:, full_name:, uid:, avatar_url:)
    return nil unless email =~ /@windevsystems.us\z/ # Only allow Windev Systems email addresses
    create_with(uid: uid, full_name: full_name, avatar_url: avatar_url).find_or_create_by!(email: email)
  end
end

module IpBanHelper
  def self.ipbanned?(ip)
    IpBan.find_by(ip: ip).present?
  end

  def self.expirationdate(ip)
    ban = IpBan.find_by(ip: ip)
    ban.until.strftime('%B %d, %Y at %I:%M %p') if ban
  end

  def self.appealabledate(ip)
    ban = IpBan.find_by(ip: ip)
    ban.appealabledate.strftime('%B %d, %Y at %I:%M %p') if ban
  end

  def self.appealable?(ip)
    ban = IpBan.find_by(ip: ip)
    ban.appealable if ban
  end

  def self.banreason(ip)
    ban = IpBan.find_by(ip: ip)
    ban.reason if ban
  end
end

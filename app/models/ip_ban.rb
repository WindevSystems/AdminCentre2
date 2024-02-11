class IpBan < ApplicationRecord
  def self.delete_expired
    where('until < ?', Time.now).delete_all
  end

  def self.make_appealable
    where('appealabledate < ?', Time.now).update_all(appealable: true)
  end
end

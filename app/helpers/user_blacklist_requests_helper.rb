module UserBlacklistRequestsHelper
  def consolidatestatus(ublr)
    return 'Pending Investigation' if ublr.status == 0
    return 'Under Investigation' if ublr.status == 1
    return 'Accepted' if ublr.status == 2
    return 'Accepted w/ minor changes' if ublr.status == 3
    return 'Rejected' if ublr.status == 4
    'Invalid Status - contact it@windevsystems.us with TUID'
end
end

module LicenseHelper
  def kgcstatusprettify(holder)
    return 'Suspended' if holder.kgc_license == 2
    return 'Licensed' if holder.kgc_license == 1
    'Unlicensed (or invalid)'
  end
  def timeclockstatusprettify(holder)
    return 'Suspended' if holder.timeclock_license == 2
    return 'Licensed' if holder.timeclock_license == 1
    'Unlicensed (or invalid)'
  end
end

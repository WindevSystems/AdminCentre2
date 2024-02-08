module AdminsHelper
  def consolidate_roles(admin)
    return 'Super Admin' if admin.superadmin
    return 'Admin' if admin.admin
    return 'Lesser Admin' if admin.lesseradmin
    return 'Support' if admin.support
    'None'
  end
end

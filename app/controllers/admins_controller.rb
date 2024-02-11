class AdminsController < ApplicationController
  # probably the most important controller to authenticate
  before_action :authenticate_admin!
  if ENV["CODESPACES"]
    skip_before_action :verify_authenticity_token, only: [:create, :destroy, :update]
  end

  # ldap

  def index
    @admins = Admin.all
  end

  def edit
    @admin = Admin.find(params[:uid])
  end

  def update
    @admin = Admin.find(params[:uid])
    if current_admin.support? or current_admin.lesseradmin? or current_admin.id != @admin.id and !current_admin.superadmin or current_admin.admin?
      flash[:error] = "You do not have permission to do that."
      redirect_to admins_path
      return
    else
      if @admin.update(admin_params)
        redirect_to admins_path
      else
        render 'edit'
      end
    end
  end

  def destroy
    @admin = Admin.find(params[:uid])
    if current_admin.support? or current_admin.lesseradmin? or current_admin.admin? or current_admin.id == @admin.id
      flash[:error] = "You do not have permission to do that."
      redirect_to admins_path
      return
    else
      @admin.destroy
      redirect_to admins_path
    end
  end

  def show
    @admin = Admin.find(params[:uid])
  end

  private

  def admin_params
    params.require(:admin).permit(:email, :avatar_url, :superadmin, :admin, :lesseradmin, :support, :disabled, :full_name, :uid, :bio, :theme)
  end
end

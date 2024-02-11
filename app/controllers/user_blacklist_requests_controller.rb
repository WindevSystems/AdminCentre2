class UserBlacklistRequestsController < ApplicationController
  if ENV["CODESPACES"]
    skip_before_action :verify_authenticity_token, only: [:create, :destroy, :update]
  end
  before_action :authenticate_admin!, only: [:index, :new, :create, :edit, :update, :destroy]

  def index
    if current_admin.admin?
      # let them see all requests if they have blacklist perms
      @user_blacklist_request = UserBlacklistRequest.all
    elsif current_admin.lesseradmin?
      # let them only see their requests if they only have request perms
      @user_blacklist_request = UserBlacklistRequest.where(requesteremail: current_admin.email.to_s)
    else
      flash[:error] = "You do not have permission to do that."
      redirect_to root_path
    end
  end

  def new
    @user_blacklist_request = UserBlacklistRequest.new
  end

  def create
    if current_admin.support?
      flash[:error] = "You do not have permission to do that."
      redirect_to user_blacklist_requests_path
      return
    else
    @user_blacklist_request = UserBlacklistRequest.new(ublr_params)
    if @user_blacklist_request.save
      redirect_to user_blacklist_requests_path
    else
      render 'new'
    end
  end
  end

  def edit
    @user_blacklist_request = UserBlacklistRequest.find_by(targetuserid: params[:tuid])
  end


  def update
    if current_admin.support? or current_admin.lesseradmin?
      flash[:error] = "You do not have permission to do that."
      redirect_to user_blacklists_path
      return
    else
    @user_blacklist_request = UserBlacklistRequest.find_by(targetuserid: params[:tuid])
    puts params
    if @user_blacklist_request.update(ublr_params)
      redirect_to user_blacklists_path
    else
      render 'edit'
    end
  end
  end

  def destroy
    # unsure if we'll use this but it's here until we make that decision
    @user_blacklist_request = UserBlacklistRequest.find_by(targetuserid: params[:tuid])
    @user_blacklist_request.destroy

    redirect_to user_blacklists_path
  end

  private
  def ublr_params
    params.require(:user_blacklist_requests).permit(:targetuserid, :suggestedlevel, :reason, :evidence, :requesteremail, :status, :claimeremsil, :claimed, :licenserevocneeded, :completed)
  end
end

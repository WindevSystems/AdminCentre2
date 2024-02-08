class UserBlacklistsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create, :destroy, :update]
  before_action :authenticate_admin!, only: [:index, :new, :create, :edit, :update, :destroy]

  def isuserblacklisted
    @user_blacklist = UserBlacklist.find_by(userid: params[:userid])
    if @user_blacklist.nil?
      render json: {blacklisted: false}
    else
      render json: {blacklisted: true, reason: @user_blacklist.reason, level: @user_blacklist.level}
    end
  end

  def index
    @user_blacklist = UserBlacklist.all
  end

  def new
    @user_blacklist = UserBlacklist.new
  end

  def create
    if current_admin.support? or current_admin.lesseradmin?
      flash[:error] = "You do not have permission to do that."
      redirect_to user_blacklists_path
      return
    else
    @user_blacklist = UserBlacklist.new(user_blacklist_params)
    if @user_blacklist.save
      redirect_to user_blacklists_path
    else
      render 'new'
    end
  end
  end

  def edit
    @user_blacklist = UserBlacklist.find_by(userid: params[:userid])
  end


  def update
    if current_admin.support? or current_admin.lesseradmin?
      flash[:error] = "You do not have permission to do that."
      redirect_to user_blacklists_path
      return
    else
    @user_blacklist = UserBlacklist.find_by(userid: params[:userid])
    puts params
    if @user_blacklist.update(user_blacklist_params)
      redirect_to user_blacklists_path
    else
      render 'edit'
    end
  end
  end

  def destroy
    @user_blacklist = UserBlacklist.find_by(userid: params[:userid])
    @user_blacklist.destroy

    redirect_to user_blacklists_path
  end

  private
  def user_blacklist_params
    params.require(:user_blacklist).permit(:userid, :reason, :level)
  end
end

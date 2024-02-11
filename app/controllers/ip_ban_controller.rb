class IpBanController < ApplicationController
  def index
    @ip_bans = IpBan.all
  end

  def new
    @ip_ban = IpBan.new
  end

  def create
    @ip_ban = IpBan.new(ip_ban_params)
    if @ip_ban.save
      redirect_to ip_ban_index_path
    else
      render 'new'
    end
  end

  def destroy
    @ip_ban = IpBan.find(params[:id])
    @ip_ban.destroy
    redirect_to ip_ban_index_path
  end

  private
  def ip_ban_params
    params.require(:ip_ban).permit(:ip, :reason, :actioneremail, :incidentid, :until, :appealabledate, :appealable)
  end
end

class LicensesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create, :destroy, :update]
  before_action :authenticate_admin!, only: [:index, :new, :create, :edit, :update, :destroy]

  def getlicenses
    # really we don't need to do much, all logic is handled client side
    @license = License.find_by(userid: params[:userid])
    if @license.nil?
      # create a blank object so we can return...something
      @license = License.new(userid: params[:userid], kgc_license: 0, timeclock_license: 0, comment: "Created after API request").save
      render json: { success: true, licenses: { kgc: @license.kgc_license.to_i, timeclock: @license.timeclock_license.to_i } }
    else
      render json: { success: true, licenses: { kgc: @license.kgc_license.to_i, timeclock: @license.timeclock_license.to_i } }
    end
  end

  def restauth(token)
    skip_before_action :authenticate_admin!
    # API endpoint for authenticating purchases from the Hub
    if token == ENV['HUB_API_TOKEN']
      return true
    else
      return false
    end
  def purchasehandling
    # API endpoint for handling license purchases
    # assume the license object exists beforehand because getlicenses creates one and hub gets that endpoint first
    @license = License.find_by(userid: params[:userid])
    if @license.nil?
      render json: { success: false, error: "No license object found for that user" }
      return
    end
    if restauth(params[:token]) == false
      render json: { success: false, error: "CONGRATULATION!!! Youve been IP banned." }
      IpBan.create(ip: request.remote_ip, reason: "Generic Security Suite™®: Unauthorized API access (token mismatch)", actioneremail: "API", incidentid: "API", until: "9999-12-31 23:59:59", appealabledate: nil, appealable: false)
      return
    end
    local purchase = params[:purchasedlicense]
    if purchase == "kgc" and @license.kgc_license == 0
      @license = License.find_by(userid: params[:userid])
      if @license.nil?
        render json: { success: false, message: "We're sorry, an error occurred. A report has been sent to the developers." }
      else
        @license.update(kgc_license: 1)
        render json: { success: true, message: "License granted" }
      end
    elsif purchase == "timeclock" and @license.timeclock_license == 0
      @license = License.find_by(userid: params[:userid])
      if @license.nil?
        render json: { success: false, message: "We're sorry, an error occurred. A report has been sent to the developers." }
      else
        @license.update(timeclock_license: 1)
        render json: { success: true, message: "License granted" }
      end
    else
      render json: { success: false, message: "Grant failure. Unknown product or already purchased/license suspended" }
    end
  end
end

  def index
    @license = License.all
  end

  def new
    @license = License.new
  end

  def create
    @license = License.new(license_params)
    if @license.save
      redirect_to licenses_path
    else
      render 'new'
    end
  end

  def edit
    @license = License.find_by(userid: params[:userid])
  end


  def update
    @license = License.find_by(userid: params[:userid])
    if @license.update(license_params)
      redirect_to licenses_path
    else
      render 'edit'
    end
  end

  def destroy
    @license = License.find_by(userid: params[:userid])
    @license.destroy

    redirect_to licenses_path
  end

  private

  def license_params
    params.require(:license).permit(:userid, :kgc_license, :timeclock_license, :comment)
  end
end

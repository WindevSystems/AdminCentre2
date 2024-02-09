class LicensesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create, :destroy, :update]
  before_action :authenticate_admin!, only: [:index, :new, :create, :edit, :update, :destroy]

  def getlicenses
    # really we don't need to do much, all logic is handled client side
    @license = License.find_by(userid: params[:userid])
    if @license.nil?
      render json: { success: false, message: "licenses returned nil (likely no purchased products)" }
    else
      render json: { success: true, licenses: { kgc: @license.kgc_license.to_i, timeclock: @license.timeclock_license.to_i } }
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

class LicenseController < ApplicationController
  before_action :authenticate_admin!, only: [:index, :new, :create, :edit, :update, :destroy]

  def getlicenses
    # really we don't need to do much, all logic is handled client side
    @licenses = License.find_by(userid: params[:userid])
    render json: {userid: @licenses.userid, products: @licenses.products, suspendedproducts: @licenses.suspendedproducts}
  end

  def index
    @licenses = License.all
  end

  def new
    @license = License.new
  end

  def create
    @license = License.new(license_params)
    if @license.save
      redirect_to license_path
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
      redirect_to license_path
    else
      render 'edit'
    end
  end

  def destroy
    @license = license.find_by(userid: params[:userid])
    @license.destroy

    redirect_to user_blacklists_path
  end

  private

  def license_params
    params.require(:user_blacklist).permit(:userid, :products, :suspendedproducts)
  end
end

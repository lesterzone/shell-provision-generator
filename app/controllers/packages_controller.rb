class PackagesController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :set_package, only: [:show, :update, :destroy]

  # GET /packages
  def index
    if params[:search]
      return render json: Package.search(params[:search], params[:platformId])
    end
    @packages = Package.all
  end

  # GET /packages/1
  # GET /packages/1.json
  def show
  end

  # GET /packages/new
  def new
    @package = Package.new
  end

  # GET /packages/1/edit
  def edit
    respond_to do |format|
      if !current_user
        return format.html { redirect_to packages_url, notice: 'Only owner can edit'} 
      end
      @package = Package.find(params[:id])
      platform = @package.platform
      @package.platform_search = platform ? platform.name : ''
      if current_user.id != @package.user_id
        format.html { redirect_to packages_url, notice: 'Only owner can edit'}
      else
        format.html
      end
    end
  end

  # POST /packages
  # POST /packages.json
  def create
    @package = Package.new(package_params)
    @package.user_id = current_user.id

    respond_to do |format|
      if @package.save
        format.html { redirect_to @package, notice: 'Package was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /packages/1
  # PATCH/PUT /packages/1.json
  def update
    respond_to do |format|
      if @package.update(package_params)
        format.html { redirect_to @package, notice: 'Package was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /packages/1
  # DELETE /packages/1.json
  def destroy
    @package.destroy
    respond_to do |format|
      format.html { redirect_to packages_url, notice: 'Package was successfully destroyed.' }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_package
    @package = Package.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def package_params
    params.require(:package).permit(:name, :version, :install, :platform_id)
  end
end

class PlatformsController < ApplicationController
  before_action :set_platform, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :index]

  # GET /platforms
  # GET /platforms.json
  def index
    if params[:search]
      return render json: Platform.search(params[:search])
    end
    @platforms = Platform.all
  end

  # GET /platforms/1
  # GET /platforms/1.json
  def show
  end

  # GET /platforms/new
  def new
    @platform = Platform.new
  end

  # GET /platforms/1/edit
  def edit
    respond_to do |format|
      if !current_user
        return format.html { redirect_to platforms_url, notice: 'Only owner can edit'}
      end
      if @platform.user_id != current_user.id
        format.html { redirect_to platforms_url, notice: 'Only owner can edit'}
      else
        format.html 
      end
    end
  end

  # POST /platforms
  # POST /platforms.json
  def create
    @platform = Platform.new(platform_params)
    @platform.user_id = current_user.id
    respond_to do |format|
      if @platform.save
        format.html { redirect_to @platform, notice: 'Platform was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /platforms/1
  # PATCH/PUT /platforms/1.json
  def update
    respond_to do |format|
      if @platform.update(platform_params)
        format.html { redirect_to @platform, notice: 'Platform was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /platforms/1
  # DELETE /platforms/1.json
  def destroy
    @platform.destroy
    respond_to do |format|
      format.html { redirect_to platforms_url, notice: 'Platform was successfully destroyed.' }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_platform
    @platform = Platform.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def platform_params
    params.require(:platform).permit(:name, :codename, :version, :install_command)
  end
end

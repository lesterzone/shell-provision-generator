class ProvisionsController < ApplicationController
  before_action :set_provision, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :index]

  # GET /provisions
  # GET /provisions.json
  def index
    @provisions = Provision.all
  end

  # GET /provisions/1
  # GET /provisions/1.json
  def show
    respond_to do |format|
      format.html
      format.json { render json: @provision.script }
      format.text { render text: @provision.script }
    end
  end

  # GET /provisions/new
  def new
    @provision = Provision.new
  end

  # GET /provisions/1/edit
  def edit
    respond_to do |format|
      if !current_user
        return format.html { redirect_to @provision, notice: 'Only owner can edit'}
      end
      if @provision.user_id != current_user.id
        format.html { redirect_to provisions_url, notice: 'Only owner can edit'}
      else
        format.html 
      end
    end
  end

  # POST /provisions
  def create
    @provision = Provision.new(provision_params)
    @provision.user_id = current_user.id
    respond_to do |format|
      if @provision.save
        format.html { redirect_to @provision, notice: 'Provision was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /provisions/1
  def update
    respond_to do |format|
      if @provision.update(provision_params)
        format.html { redirect_to @provision, notice: 'Provision was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /provisions/1
  # DELETE /provisions/1.json
  def destroy
    @provision.destroy
    respond_to do |format|
      format.html { redirect_to provisions_url, notice: 'Provision was successfully destroyed.' }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_provision
    @provision = Provision.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def provision_params
    params.require(:provision).permit(:script, :title)
  end
end

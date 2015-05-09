class ProvisionsController < ApplicationController
  before_action :set_provision, only: [:show, :edit, :update, :destroy]

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
  end

  # POST /provisions
  # POST /provisions.json
  def create
    @provision = Provision.new(provision_params)

    respond_to do |format|
      if @provision.save
        format.html { redirect_to @provision, notice: 'Provision was successfully created.' }
        format.json { render :show, status: :created, location: @provision }
      else
        format.html { render :new }
        format.json { render json: @provision.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /provisions/1
  # PATCH/PUT /provisions/1.json
  def update
    respond_to do |format|
      if @provision.update(provision_params)
        format.html { redirect_to @provision, notice: 'Provision was successfully updated.' }
        format.json { render :show, status: :ok, location: @provision }
      else
        format.html { render :edit }
        format.json { render json: @provision.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /provisions/1
  # DELETE /provisions/1.json
  def destroy
    @provision.destroy
    respond_to do |format|
      format.html { redirect_to provisions_url, notice: 'Provision was successfully destroyed.' }
      format.json { head :no_content }
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

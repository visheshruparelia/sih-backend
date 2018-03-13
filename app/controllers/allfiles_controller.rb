class AllfilesController < ApplicationController
  before_action :set_allfile, only: [:show, :update, :destroy]
  before_action :authenticate_user!

  # GET /allfiles
  def index
    @allfiles = Allfile.all

    render json: @allfiles
  end

  # GET /allfiles/1
  def show
    render json: @allfile
  end

  # POST /allfiles
  def create

    @allfile = Allfile.new()
    @allfile.created_by_id=current_user.id
    @allfile.currentOwner_id=current_user.id
    @allfile.name=params[:name]


    # @allfile = Allfile.new(allfile_params)

    if @allfile.save
      @userfile=FileUser.new()

      @userfile.fileId_id=@allfile.id
      @userfile.userId_id=current_user.id
      @userfile.modify=params[:modify]
      @userfile.view=params[:view]
      @userfile.save

      render json: @allfile, status: :created, location: @allfile
    else
      render json: @allfile.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /allfiles/1
  def update
    if @allfile.update(allfile_params)
      render json: @allfile
    else
      render json: @allfile.errors, status: :unprocessable_entity
    end
  end

  # DELETE /allfiles/1
  def destroy
    @allfile.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_allfile
      @allfile = Allfile.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def allfile_params
      params.require(:allfile)
      # params.require(:allfile).permit(:name, :qrcode, :timeRecievedCurrentOwner, :status, :customData, :history, :created_by_id, :currentOwner_id)
    end
end

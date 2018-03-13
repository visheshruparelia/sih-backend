class FileUsersController < ApplicationController
  before_action :set_file_user, only: [:show, :update, :destroy]

  # GET /file_users
  def index
    @file_users = FileUser.all

    render json: @file_users
  end

  # GET /file_users/1
  def show
    render json: @file_user
  end

  # POST /file_users
  def create
    @file_user = FileUser.new(file_user_params)

    if @file_user.save
      render json: @file_user, status: :created, location: @file_user
    else
      render json: @file_user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /file_users/1
  def update
    if @file_user.update(file_user_params)
      render json: @file_user
    else
      render json: @file_user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /file_users/1
  def destroy
    @file_user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_file_user
      @file_user = FileUser.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def file_user_params
      params.require(:file_user).permit(:modify, :view, :fileId_id, :userId_id)
    end
end

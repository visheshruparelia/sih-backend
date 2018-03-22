class Api::FileusersController < ApplicationController
  before_action :set_file_user, only: [:show, :update, :destroy]
  before_action :authenticate_user!

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
    @fileId=Allfile.find(params[:file_id]).id
    if FileUser.exists?(fileId_id: @fileId, userId_id: current_user.id)
      @userfile=FileUser.where(fileId_id: @fileId, userId_id: current_user.id).first
      if @userfile.modify
        if !params[:group_ids].nil?
          @users=FileUser.getUsers(params[:group_ids])
        elsif !params[:user_ids].nil?
          @users=params[:user_ids]
        end
        for user in @users
          if user!=current_user.id
            @userfile=FileUser.new()
            @userfile.fileId_id=@fileId
            @userfile.userId_id=user
            @userfile.modify=params[:modify]
            @userfile.view=params[:view]
            @userfile.save
          end
        end
        render json: @users, status: 200 and return
      end
    end
      render json: {"error":"Access denied"},status: :unprocessable_entity
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

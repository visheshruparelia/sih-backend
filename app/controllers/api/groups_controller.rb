class Api::GroupsController < ApplicationController
  load_and_authorize_resource except: :create
  before_action :set_group, only: [:show, :update, :destroy]
  before_action :authenticate_user!
  wrap_parameters format: [:json]
  # GET /groups
  def index
    @query=params[:name]
    if !@query.nil?
      @groups=Group.where("name like ?","%#{@query}%")
    else
      @groups = Group.where(isDepartment: true)
    end
    render json: @groups
  end

  # GET /groups/1
  def show
    render json: @group
  end

  # POST /groups
  def create
    @group = Group.new()
    @group.name = params[:name]
    @group.isDepartment = params[:isDepartment]
    @group.dept_id=params[:dept_id]
    if @group.save
      render json: @group, status: :created
    else
      render json: @group.errors, status: :unprocessable_entity
    end
    authorize! :create, @group
  end

  # PATCH/PUT /groups/1
  def update
      if @group.update(group_params)
        @usergroup=GroupUser.where(group_id: @group.id, user_id: current_user.id).first
        if !params[:defaultIncoming].nil?
            @usergroup.update(defaultIncoming: params[:defaultIncoming])
        end
        render json: @group
      else
        render json: @group.errors, status: :unprocessable_entity
      end
  end

  # DELETE /groups/1
  def destroy
    @group.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def group_params
      params.require(:group)
    end
end

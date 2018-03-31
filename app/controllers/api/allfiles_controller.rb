class Api::AllfilesController < ApplicationController
  before_action :set_allfile, only: [:show, :update, :destroy]
  before_action :authenticate_user!
  wrap_parameters format: [:json]
  # GET /allfiles
  def index
    @files = Allfile.all
    @allfiles=[]
    for file in @files
      @file=JSON.parse(file.to_json)
      @currentOwner=User.find(file.currentOwner_id)
      @file["currentOwner"]={name: @currentOwner.name , id: @currentOwner.id}
      @allfiles.push(@file)
    end
    render json: @allfiles
  end

  # GET /allfiles/1
  def show

    @file = JSON.parse(@allfile.to_json)
    @currentOwner=User.find(@allfile.currentOwner_id)
    @createdBy=User.find(@allfile.created_by_id)
    @file["currentOwner"]={ name: @currentOwner.name , id: @currentOwner.id}
    @file["createdBy"]={ name: @createdBy.name , id: @createdBy.id}

    @file.to_json
    render json: @file

  end

  # POST /allfiles
  def create
    @allfile = Allfile.new()
    @allfile.created_by_id=current_user.id
    @allfile.currentOwner_id=current_user.id
    @allfile.registeredBy=params[:registeredBy]
    @allfile.name=params[:name]
    @allfile.fileId=params[:fileId]
    @allfile.timeRecievedCurrentOwner=Time.now
    @allfile.customData=params[:customData]
    @allfile.group_id_id=GroupUser.where(user_id: current_user.id).first.group_id
    if !params[:priority].nil?
      @allfile.priority=params[:priority]
    end
    @allfile.history.push(current_user.id)
    # @allfile = Allfile.new(allfile_params)

    if @allfile.save
      @history = History.new()
      @history.file_id = @allfile.id
      @history.change_time = Time.now
      @history.status_to = 0
      @history.changed_by_id=current_user.id
      @history.save

      @userfile=FileUser.new()
      @userfile.fileId_id=@allfile.id
      @userfile.userId_id=current_user.id
      @userfile.modify=true
      @userfile.view=true
      @userfile.save

      render json: @allfile, status: :created
    else
      render json: @allfile.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /allfiles/1
  def update
    if params[:mode].eql?"receive"
        if GroupUser.exists?(group_id: @allfile.group_id_id, user_id: current_user.id)
          @temp=History.where(file_id: @allfile.id, status_from:0, status_to:1)
          n=@temp.size
          if !@temp[n-1].nextNode.nil?
            @allfile.status=1
            @history = History.new()
            @history.file_id = @allfile.id
            @history.change_time = Time.now
            @history.status_from = 1
            @history.status_to = 0
            @history.changed_by_id= current_user.id
            @history.nextNode=params[:nextNode]
            @history.save
          else
            @history = History.new()
            @history.file_id = @allfile.id
            @history.change_time = Time.now
            @history.status_from = 1
            @history.status_to = 0
            @history.changed_by_id= current_user.id
            @history.nextNode=params[:nextNode]
            @history.save
          end

        render json: @allfile, status:200
      else
        render json: {"error":"File hasn't been transferred to you"}, status: 403
      end
    end
    if params[:mode].eql?"transfer"
      @allfile.status=1
      @allfile.updated_at=Time.now
      if !params[:nextNode].nil?
        @history = History.new()
        @history.file_id = @allfile.id
        @history.change_time = Time.now
        @history.status_from = 0
        @history.status_to = 1
        @history.changed_by_id= current_user.id
        @history.nextNode=params[:nextNode]
        @history.save
        @allfile.group_id_id=params[:sectionId]
        @allfile.dept_id=params[:deptId]
      else
        @history = History.new()
        @history.file_id = @allfile.id
        @history.change_time = Time.now
        @history.status_from = 0
        @history.status_to = 1
        @history.changed_by_id= current_user.id
        @history.nextNode=nil
        @history.save
        @allfile.group_id_id= params[:sectionId]
        @allfile.dept_id= params[:deptId]
      end
      @allfile.save

      render json: @allfile
    end
    if params[:mode].eql?"update" #check modify/view access

      @currstatus=@allfile.status
      if @allfile.update(allfile_params)
          if @currstatus!=params[:status]
              @history = History.new()
              @history.file_id = @allfile.id
              @history.change_time = Time.now
              @history.status_from =@currstatus
              @history.status_to = params[:status]
              @history.changed_by_id= current_user.id
              @history.save
          end
        render json: @allfile and return
      end
    end
 end

  # DELETE /allfiles/1
  def destroy
      @userfile=FileUser.where(fileId_id: @allfile.id, userId_id: current_user.id).first
      if @userfile.modify || true
          @allfile.destroy
      else
          render json: {
          "error": "Access denied",
          },status: :unprocessable_entity
      end
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

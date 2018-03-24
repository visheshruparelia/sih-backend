class Api::AllfilesController < ApplicationController
  before_action :set_allfile, only: [:show, :update, :destroy]
  before_action :authenticate_user!
  wrap_parameters format: [:json]
  # GET /allfiles
  def index
    @files = Allfile.all
    @allfiles=[]
    for file in @files
      if FileUser.exists?(fileId_id: file.id,userId_id: current_user.id)
        @userfile=FileUser.where(fileId_id: file.id, userId_id: current_user.id).first
        if @userfile.view
          @file=JSON.parse(file.to_json)
          @currentOwner=User.find(file.currentOwner_id)
          @file["currentOwner"]={name: @currentOwner.name , id: @currentOwner.id}
          @allfiles.push(@file)
        end
      else
        @file=JSON.parse(file.to_json)
        @currentOwner=User.find(file.currentOwner_id)
        @file["currentOwner"]={name: @currentOwner.name , id: @currentOwner.id}
        @allfiles.push(@file)
      end
    end
    render json: @allfiles
  end

  # GET /allfiles/1
  def show
    if FileUser.exists?(fileId_id: @allfile.id, userId_id: current_user.id)
      @userfile=FileUser.where(fileId_id: @allfile.id, userId_id: current_user.id).first
      if !@userfile.view
        render json: {"error":"You don't have view privileges"}, status:401 and return
      end
    end

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
    @allfile.name=params[:name]
    @allfile.timeRecievedCurrentOwner=Time.now
    @allfile.customData=params[:customData]
    if !params[:priority].nil?
      @allfile.priority=params[:priority]
    end
    @allfile.history.push(current_user.id)
    # @allfile = Allfile.new(allfile_params)

    if @allfile.save
      @history = History.new()
      @history.file_id = @allfile.id
      @history.change_time = Time.now
      @history.status_from = 2
      @history.status_to = 0
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
    if params[:cunt].eql?"receive"
      if current_user.id==@allfile.currentOwner_id
        @allfile.history.push(current_user.id)
        @allfile.status=0
        @allfile.currentOwner_id=current_user.id
        @allfile.timeRecievedCurrentOwner=Time.now
        @allfile.updated_at=Time.now
        @allfile.save

        @history = History.new()
        @history.file_id = @allfile.id
        @history.change_time = Time.now
        @history.status_from = 1
        @history.status_to = 0
        @history.changed_by_id= current_user.id
        @history.save

        render json: @allfile, status:200
      else
        render json: {"error":"File hasn't been transferred to you"}, status: 403
      end
    end
    if params[:cunt].eql?"transfer"
      @allfile.status=1
      @allfile.updated_at=Time.now
      if !params[:user_id].nil?
          @allfile.currentOwner_id = params[:user_id]
      elsif !params[:group_id].nil? and !GroupUser.getDefaultincoming(params[:group_id]).nil?
          @allfile.currentOwner_id = GroupUser.getDefaultincoming(params[:group_id])
      elsif GroupUser.getDefaultincoming(params[:group_id]).nil?
          render json: {"error":"No defaultIncoming node"}, status:404
      else
          render json: {"error":"Specify the User/group_id"}, status:404
      end
      @allfile.save


      @history = History.new()
      @history.file_id = @allfile.id
      @history.change_time = Time.now
      @history.status_from = 0
      @history.status_to = 1
      @history.changed_by_id= current_user.id
      @history.save
      render json: @allfile
    end
    if params[:cunt].eql?"update" #check modify/view access
      if FileUser.exists?(fileId_id: @allfile.id,userId_id: current_user.id)
          @userfile=FileUser.where(fileId_id: @allfile.id, userId_id: current_user.id).first
          if(@userfile.modify)
            if @allfile.update(name: params[:name],status: params[:status],customData: params[:customData],priority: params[:priority])
              render json: @allfile and return
            end
          end
      else
        render json: {"error":"You don't have modify privsadafileges"}, status:401
      end
    end
 end

  # DELETE /allfiles/1
  def destroy
      @userfile=FileUser.where(fileId_id: @allfile.id, userId_id: current_user.id).first
      if @userfile.modify
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

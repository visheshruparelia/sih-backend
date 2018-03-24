class Api::HistoryController < ApplicationController
    before_action :set_history, only: [:show]
    before_action :authenticate_user!

    # GET /file/1/history
    def show
      if FileUser.exists?(fileId_id: params[:id], userId_id: current_user.id)
        @userfile=FileUser.where(fileId_id: params[:id], userId_id: current_user.id).first
        if !@userfile.view
          render json: {"error":"You don't have view privileges"}, status:401 and return
        end
      end

      @filehistory=[]
      for history in @histories
        @history=JSON.parse(history.to_json)
        @user=User.find(history.changed_by_id)
        @history['users']={name: @user.name, id: @user.id}
        @filehistory.push(@history)
      end

      render json: @filehistory
    end
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_history
        @histories = History.where(file_id: params[:id])
      end
end

  class Api::HistoryController < ApplicationController
    before_action :set_history, only: [:show,:lastuser]
    before_action :authenticate_user!

    # GET /file/1/history
    def show

      @filehistory=[]
      for history in @histories
        @history=JSON.parse(history.to_json)
        @user=User.find(history.changed_by_id)
        @history['users']={name: @user.name, id: @user.id}
        @filehistory.push(@history)
      end

      render json: @filehistory
    end

    def lastuser
      @filehistory=[]
      for history in @histories
        @history=JSON.parse(history.to_json)
        @user=User.find(history.changed_by_id)
        @history['users']={name: @user.name, id: @user.id}
        @filehistory.push(@history)
      end
      @filehistory.pop()
      @last_user = @filehistory.pop()
      render json: @last_user
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_history
        @histories = History.where(file_id: params[:id])
      end
end

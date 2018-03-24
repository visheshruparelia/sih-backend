class Api::HistoryController < ApplicationController
    before_action :set_history, only: [:show]

    # GET /file/1/history
    def show
        render json: @history
    end
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_history
        @history = History.find(params[:id])
      end
end

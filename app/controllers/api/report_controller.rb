class Api::ReportController < ApplicationController
  before_action :authenticate_user!

  def create
    @report=Hash.new
    @id=params[:id]
    @total_time=0


    @totalfilestransferred=0
    @files_transferred=[]
    @file_transfer_rows=History.where(changed_by_id: @id,status_from: 0, status_to: 1)
    @file_transfer_rows.each do |row|
      @totalfilestransferred+=1
      @files_transferred.push([row.file_id,Allfile.find(row.file_id).name])
    end

    @totalfileslost=0
    @files_lost=[]
    @lostfiledata=Hash.new
    @file_lost_rows=History.where(changed_by_id: @id,status_to: 3)
    @file_lost_rows.each do |row|
      @file_prev_rows=History.where(file_id: row.file_id)
      @file_prev_rows.pop()
      prevrow = @file_prev_row.pop()
      @files_lost_between.push([prevrow.changed_by_id,@id])
      @totalfileslost+=1
      @files_lost.push([row.file_id,Allfile.find(row.file_id).name])
    end

    @totalfileslegalhold=0
    @files_legalhold=[]
    @file_legalhold_rows=History.where(changed_by_id: @id,status_to: 2)
    @file_legalhold_rows.each do |row|
      @totalfileslegalhold+=1
      @files_legalhold.push([row.file_id,Allfile.find(row.file_id).name])
    end
    @report.store('TotalFilesTransferred',@totalfilestransferred)
    @report.store('FilesTransferred',@files_transferred)

    @report.store('filesLostBetween', @files_lost_between)
    @report.store('TotalFilesLost',@totalfileslost)
    @report.store('FilesLost',@files_lost)

    @report.store('TotalFilesLegalHold',@totalfileslegalhold)
    @report.store('FilesLegalHold',@files_legalhold)

    render json: @report
  end
end

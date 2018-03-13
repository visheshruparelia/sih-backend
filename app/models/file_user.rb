class FileUser < ApplicationRecord
  belongs_to :user, foreign_key: 'userId_id'
  belongs_to :allfile, foreign_key: 'fileId_id'

end

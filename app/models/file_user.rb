class FileUser < ApplicationRecord
  belongs_to :fileId
  belongs_to :userId
end

class Allfile < ApplicationRecord
  belongs_to :user, foreign_key: 'currentOwner_id' 
  belongs_to :user, foreign_key: 'created_by_id'
end

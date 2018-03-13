class GroupGroup < ApplicationRecord
  belongs_to :group, foreign_key: 'groupId_id'
  belongs_to :group, foreign_key: 'authorityOver_id'

end

class Department < ApplicationRecord
  has_one :user, foreign_key: 'head_id'
end

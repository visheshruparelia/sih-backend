class Allfile < ApplicationRecord
  require 'set'

  belongs_to :user, foreign_key: 'currentOwner_id'
  belongs_to :user, foreign_key: 'created_by_id'

  enum status: [ :normal,:intransit,:legalhold, :lost, :etc]
  enum priority: [ :low, :medium, :high]
  serialize :history, Array

end

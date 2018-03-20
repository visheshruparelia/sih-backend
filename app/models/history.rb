class History < ApplicationRecord
    # enum status: [ :normal,:intransit,:legalhold, :lost, :etc], _suffix: true
    enum status_to: [ :normal,:intransit,:created ,:legalhold, :lost, :etc], _suffix: true
    enum status_from: [ :normal,:intransit,:legalhold, :lost, :etc], _suffix: true
    belongs_to :user, foreign_key: 'changed_by_id'
    belongs_to :allfile, foreign_key: 'file_id'
end

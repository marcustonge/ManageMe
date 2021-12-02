class Task < ApplicationRecord
    #Tasks belong to events and users
    belongs_to :event
    belongs_to :user
end

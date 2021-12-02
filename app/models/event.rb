class Event < ApplicationRecord
  #events belong to a user and can have many tasks, if the event is deleted then so are the tasks associated with it
  belongs_to :user
  has_many :tasks, dependent: :destroy
end

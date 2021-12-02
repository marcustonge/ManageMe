class User < ApplicationRecord
has_person_name

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  #User can have many events, if the user is destroyed then the event is destroyed and the tasks related to the user are also destroyed
  has_many :events, dependent: :destroy
  has_many :tasks, dependent: :destroy
end

class User < ApplicationRecord
has_person_name

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  #User can have many events, if the user is destroyed then the event is destroyed
  has_many :events, dependent: :destroy
  has_many :comments, dependent: :destroy
end

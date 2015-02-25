class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
 
  has_many :wikis
  
  has_many :collaborators
  #has_many :wikis_that_i_collaborate_on, through: :collaborators, source: :wiki
  
  def admin?
     role == 'admin'
   end
 
 def moderator?
   role == 'moderator'
 end
  
  def member?
    role == 'member'
  end
  
  def premium?
    role == 'premium'
  end
  
  
  
  
end

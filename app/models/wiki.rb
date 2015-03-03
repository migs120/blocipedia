class Wiki < ActiveRecord::Base
  belongs_to :user
  
  has_many :collaborators
  has_many :users, through: :collaborators
  
  default_scope { order('created_at DESC') }
  
  
  # hay5 = $user12                     #"admin" == 'admin' ? "yes" : "no"
  
  #scope :visible_to, -> (user) { user ? all : where(private: false) }
                             #   if a then b else c end === a ? b : c
  
  
  scope :public_only, -> { where(private: false )} 
  scope :visble_for, -> (userfufu) { userfufu ? all : where(private: false) }
  
  # hay5 = $user12                     #"admin" == 'admin' ? "yes" : "no"
  
  scope :visible_to, -> (user) {
    user.present? || user.blank? ?
      where(:private => false) : where(:private => false).or(:id => user.wiki_ids)
  } #user ? all : where(private: false) }
                             #   if a then b else c end === a ? b : c
 

  
end

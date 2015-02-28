class Wiki < ActiveRecord::Base
  belongs_to :user
  
  has_many :collaborators
  has_many :users, through: :collaborators
  
  # hay5 = $user12                     #"admin" == 'admin' ? "yes" : "no"
  
  #scope :visible_to, -> (user) { user ? all : where(private: false) }
                             #   if a then b else c end === a ? b : c
  
  default_scope { order('created_at DESC') }
  
  # hay5 = $user12                     #"admin" == 'admin' ? "yes" : "no"
  
  scope :visible_to, -> (user) {
    user.present? || user.blank? ?
      where(:private => false) : where(:private => false).or(:id => user.wiki_ids)
  } #user ? all : where(private: false) }
                             #   if a then b else c end === a ? b : c
  
  
  
end

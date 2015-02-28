class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
    # user.present? && (record.user == user || user.admin?) 
  end

  def show?
    
    scope.where(:id => record.id).exists?
   
  end

  def create?
    user.present?
    #true
  end

  def new?
    create?
  end

  def update?
    #user.present? && (record.user == user || user.admin?)  #user == user restricts other collaborators
    user.present?
    
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end


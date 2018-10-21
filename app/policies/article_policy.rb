class ArticlePolicy < ApplicationPolicy

    def create?
        (!user.nil?) && (user.role? :admin)
    end

    def edit?
        !user.nil? && ((user.role? :admin) || (@record.user.id == user.id))
    end

    def update?
        !user.nil? && ((user.role? :admin) || (@record.user.id == user.id))
    end

    def destroy?
        !user.nil? && ((user.role? :admin) || (@record.user.id == user.id))
    end
    
    def revive?
        !user.nil? && ((user.role? :admin) || (@record.user.id == user.id))
    end
    
end
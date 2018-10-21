class CommentPolicy < ApplicationPolicy

    def create?
        !user.nil?
    end

    def destroy?
        !user.nil? and ((user.role? :admin) or (user.id == record.user.id))
    end

end
class CommentPolicy < ApplicationPolicy

    def create?
        !user.nil?
    end

    def destroy?
        (user.role? :admin) or (user.id == record.user.id)
    end

end
class UserPolicy < ApplicationPolicy

    def index?
        !user.nil? and user.role? :admin
    end

    def show?
        !user.nil? and user.role? :admin
    end

    def create?
        user.nil?
    end

    def destroy?
        !user.nil? and user.role? :admin
    end

    def revive?
        !user.nil? and user.role? :admin
    end

    def update?
        # TODO
    end

end
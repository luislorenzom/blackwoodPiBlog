class SessionPolicy < ApplicationPolicy

    def create?
        user.nil?
    end
    
end
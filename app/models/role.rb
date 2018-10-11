class Role < ApplicationRecord

    # Validations
    validates :name, presence: true, uniqueness: true

    # Relations
    has_many :assignments
    has_many :users, through: :assignments
end
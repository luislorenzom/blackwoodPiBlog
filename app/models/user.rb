class User < ModelWithStatus

    before_save { self.email = email.downcase }

    # Validations
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

    validates :name, presence: true, length: { maximum: 50 }
    validates :email, presence: true, length: { maximum: 250 }, 
                        format: { with: VALID_EMAIL_REGEX },
                        uniqueness: true
    # Password
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }

    # Relations
    has_many :assignments
    has_many :comments
    has_many :articles
    has_many :roles, through: :assignments

    # Check if the users has the received role
    def role?(role)
        roles.any? {|r| r.name.underscore.to_sym == role}
    end

end

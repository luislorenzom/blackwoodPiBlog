class Comment < ModelWithStatus

  # Validations
  validates :body, presence: true
  
  # Relations
  belongs_to :article
  belongs_to :user
  
end

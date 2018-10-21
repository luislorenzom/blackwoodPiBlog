class Like < ApplicationRecord
    belongs_to :article, class_name: "Article"
    belongs_to :user, class_name: "User"
  end
  
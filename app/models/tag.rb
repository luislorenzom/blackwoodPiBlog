class Tag < ApplicationRecord

	before_save { self.name = name.downcase }
	
	# Scopes (to apply filter)
	scope :tag_name, -> (name) { where("tags.name LIKE (?)", "#{name}")}

	# Default order by
	default_scope { order(name: :asc) }

	# Validations
	validates :name, presence: true

	# Relations
	has_many :taggeds
	has_many :articles, through: :taggeds
end

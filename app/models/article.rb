class Article < ModelWithStatus

    # Scopes (to apply filter)
    scope :title, -> (title) { where("articles.title LIKE (?)", "%#{title}%")}
    scope :text, -> (text) { where("articles.text LIKE (?)", "%#{text}%")}
    scope :tagged_with_tag, -> (tag_name) { joins(:tags).merge(Tag.tag_name(tag_name))}
    scope :creator, -> (creator_name) { joins(:user).merge(User.username(creator_name))}

    # Validations
    validates :title, presence: true,
                length: {minimum:3, maximum:35}
    validates :text, presence: true
    
    # Relations
    has_many :taggeds
    has_many :tags, through: :taggeds
    has_many :comments
    belongs_to :user
    has_many :likes
    has_many :users_lovers, through: :likes, :source => :user

    # Default order by
    default_scope { order(created_at: :desc) }

end

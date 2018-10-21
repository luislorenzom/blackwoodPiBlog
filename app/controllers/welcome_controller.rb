class WelcomeController < ApplicationController
  def index
    # All articles
    @articles = Article.where(enabled:true).paginate(:page => params[:page], :per_page => 5)
    
    # Fixed articles
    @fixed_articles = Article.tagged_with_tag("fixed")

    # Top articles
    @likes_per_article = Article.joins(:likes).group(:id).limit(3).count(:id)
    @top_articles = Article.joins(:likes).select('articles.*, COUNT(articles.id) AS likes').group(:id).limit(3)
  end
end

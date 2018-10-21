module ArticlesHelper
    include ApplicationHelper

    # ------------------------------------------------------------
    # Gets the most similar articles with the article received 
    # 
    # TODO: could be interesting use the current user's likes
    # to improve this recommendation system
    # ------------------------------------------------------------
    def get_recommended_candidates(article)
        @tags = article.tags.map {|t| t.name }
        @candidates_id = Article.joins(:tags).select('articles.*').where('tags.name IN (?) AND articles.id != ? AND articles.enabled = 1', @tags, article.id).group(:id).count(:id).sort_by {|k,v| v}.reverse.take(3).map{|k,v| k}
        return Article.where(id: @candidates_id)
    end

end

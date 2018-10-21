class SearchController < ApplicationController

    # ------------------------------------------------------------
    # Search articles by several criterias:
    # q => token which appears into the article's body or title
    # tag => articles's tag
    # author => author's name
    # ------------------------------------------------------------
    def index
        @articles = Article.where(nil)

        @articles = @articles.creator(params[:author]) if params[:author].present?
        @articles = @articles.title(params[:q]).or(@articles.text(params[:q])) if params[:q].present?
        @articles = @articles.tagged_with_tag(params[:tag]) if params[:tag].present?
    end

end

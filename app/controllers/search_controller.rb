class SearchController < ApplicationController

    def index
        @articles = Article.where(nil)

        # Title and Text search filter
        @articles = @articles.title(params[:q]) + @articles.text(params[:q]) if params[:q].present?
        
        # Tag search filter
        @articles = @articles + Article.where(nil).tagged_with_tag(params[:tag]) if params[:tag].present?
    end

end

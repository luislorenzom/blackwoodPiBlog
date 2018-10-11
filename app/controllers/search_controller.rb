class SearchController < ApplicationController

    def index 
        @articles = Article.where(nil)

        # Title and Text search filter
        # TODO: revisar esto
        @articles = @articles.title(params[:q]) if params[:q].present?
        @articles = @articles.text(params[:q]) if params[:q].present?
        # Tag search filter
        @articles = @articles.tagged_with_tag(params[:tag]) if params[:tag].present?
    end

end

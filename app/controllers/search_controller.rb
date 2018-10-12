class SearchController < ApplicationController

    def index
        @articles = Article.where(nil)

        if params[:q].present? && params[:tag].present?
            @articles = Article.title(params[:q]).or(Article.text(params[:q])).tagged_with_tag(params[:tag])
        elsif params[:q].present?
            @articles = Article.title(params[:q]).or(Article.text(params[:q]))
        elsif params[:tag].present?
            @articles = Article.tagged_with_tag(params[:tag])
        end
    end

end

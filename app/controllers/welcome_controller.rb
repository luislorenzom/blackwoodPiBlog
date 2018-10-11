class WelcomeController < ApplicationController
  def index
    @articles = Article.where(enabled:true).paginate(:page => params[:page], :per_page => 5)
    @top_articles = Article.take(3) #CHANGE
    @fixed_articles = Article.take(3) #CHANGE
  end
end

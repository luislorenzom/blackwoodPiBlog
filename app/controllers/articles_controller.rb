class ArticlesController < ApplicationController

    include ArticlesHelper

    before_action :is_admin?, only: [:index, :new, :create]

    # ------------------------------------------------------------
    # Gets all the enabled articles
    # ------------------------------------------------------------
    def index
        @articles = Article.paginate(:page => params[:page], :per_page => 5)
    end

    # ------------------------------------------------------------
    # Shows single article
    # ------------------------------------------------------------
    def show
        @article = Article.find(params[:id])
        @comments = @article.comments.where(enabled:true)
        if not current_user.nil?
            @liked = current_user.articles_loved.include?(@article)
        else
            @liked = false
        end

        @similar_articles = get_recommended_candidates(@article)
    end

    # ------------------------------------------------------------
    # Prepares new article to will be created
    # ------------------------------------------------------------
    def new
        @article = Article.new()
    end

    # ------------------------------------------------------------
    # Prepares an article to will be edited
    # ------------------------------------------------------------
    def edit
        @article = Article.find(params[:id])
        authorize @article
        @tags = @article.tags.map{|n| n.name}
    end

    # ------------------------------------------------------------
    # Saves new article
    # ------------------------------------------------------------
    def create 
        @article = Article.new(article_params)
        @article.user = current_user

        if @article.save
            # Save the related tags
            @tags = params[:tags].split(' ')

            @tags.each do |tag|
                if Tag.where(name: tag).empty?
                    @t = Tag.new(name: tag)
                    @t.save
                else
                    @t = Tag.where(name: tag)
                end
                @article.tags.append(@t)
            end

            redirect_to @article
        else
            render 'new'
        end
    end

    # ------------------------------------------------------------
    # Updates article
    # ------------------------------------------------------------
    def update
        # Retrieves the model
        @article = Article.find(params[:id])
        # Checks policies
        authorize @article

        # Updates tags relationship
        @original_tags = @article.tags.map{|t| t.name}
        @new_tags = params[:tags].split(' ')
        @inner_tags = @original_tags & @new_tags
        
        @tags_to_delete = @original_tags - @inner_tags
        @tags_to_add = @new_tags - @inner_tags
        
        Tag.where(name: @tags_to_delete).each do |tag|
            @article.tags.delete(tag)    
        end

        @tags_to_add.each do |tag|
            if Tag.where(name: tag).empty?
                @t = Tag.new(name: tag)
                @t.save
            else
                @t = Tag.where(name: tag)
            end
            @article.tags.append(@t)
        end

        # Updates model and redirect
        if @article.update(article_params)
            redirect_to @article
        else
            render 'edit'
        end
    end

    # ------------------------------------------------------------
    # "Deletes" an article (actually changes their enabled 
    # status to "false")
    # ------------------------------------------------------------
    def destroy
        @article = Article.find(params[:id])
        authorize @article
        @article.destroy

        redirect_to articles_path
    end

    # ------------------------------------------------------------
    #  Changes the enabled status to "true"
    # ------------------------------------------------------------
    def revive
        @article = Article.find(params[:article_id])
        authorize @article
        @article.revive

        redirect_to articles_path
    end

    private 
        def article_params
            params.require(:article).permit(:title, :text, :enabled)
        end

        def is_admin?
            unless isAdmin?
                redirect_to root_path
            end
        end
end

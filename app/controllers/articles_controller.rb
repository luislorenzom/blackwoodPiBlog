class ArticlesController < ApplicationController

    def index
        @articles = Article.paginate(:page => params[:page], :per_page => 5)
    end

    def show
        @article = Article.find(params[:id])
        @comments = @article.comments.where(enabled:true)
    end

    def new
        @article = Article.new()
        authorize @article
    end

    def edit
        @article = Article.find(params[:id])
        authorize @article
        @tags = @article.tags.map{|n| n.name}
    end

    def create 
        @article = Article.new(article_params)
        @article.user = current_user
        authorize @article

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

    def destroy
        @article = Article.find(params[:id])
        authorize @article
        @article.destroy

        redirect_to articles_path
    end

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
end

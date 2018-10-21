class CommentsController < ApplicationController

    before_action :logged_user?, only: [:create, :destroy]

    # ------------------------------------------------------------
    # Creates the comment and relates this with the article
    # ------------------------------------------------------------
    def create
        @article = Article.find(params[:article_id])

        @comment = @article.comments.create(comment_params)
        @comment.user = current_user
        @comment.save
        redirect_to article_path(@article)
    end

    # ------------------------------------------------------------
    # Changes the comment enabled status to false
    # ------------------------------------------------------------
    def destroy
        @comment = Comment.joins(:article).find(params[:id])
        @comment.destroy
        redirect_to article_path(params[:article_id])
    end

    private
        def comment_params
            params.require(:comment).permit(:body)
        end

        def logged_user?
			unless logged_in?
				redirect_to root_path
			end
        end
end

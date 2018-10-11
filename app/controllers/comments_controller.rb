class CommentsController < ApplicationController

    def create
        @article = Article.find(params[:article_id])
        # TODO: securice
        @comment = @article.comments.create(comment_params)
        @comment.user = current_user
        @comment.save
        redirect_to article_path(@article)
    end

    def destroy
        @comment = Comment.joins(:article).find(params[:id])
        authorize @comment
        @comment.destroy
        redirect_to article_path(params[:article_id])
    end

    private
        def comment_params
            params.require(:comment).permit(:body)
        end
end

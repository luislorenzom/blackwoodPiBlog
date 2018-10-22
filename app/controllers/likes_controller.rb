class LikesController < ApplicationController

    before_action :logged_user?, only: [:like, :dislike]

    # ------------------------------------------------------------
    # Likes an article
    #
    # TODO: should returns the number of likes in XHR body
    # ------------------------------------------------------------
    def like
        @article = Article.find(params[:article_id])
        current_user.articles_loved.append(@article)
        # Article.find(6).likes.count()
        # render json: "asd"
    end

    # ------------------------------------------------------------
    # Removes like from an article
    #
    # TODO: should returns the number of likes in XHR body
    # ------------------------------------------------------------
    def dislike
        @article = Article.find(params[:article_id])
        current_user.articles_loved.delete(@article)
    end

    private
        def logged_user?
            if logged_in?
                redirect_to root_path
            end
        end
end

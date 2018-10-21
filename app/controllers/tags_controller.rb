class TagsController < ApplicationController

    # ------------------------------------------------------------
    # Searches all the tags which match with the query received
    # ------------------------------------------------------------
    def index
        @query = params[:q]
        if @query.nil?
            render :json => Tag.all().map { |t| t.name }
        else
            render :json => Tag.where("name LIKE (?)", "#{@query}%").map { |t| t.name }
        end
    end
    
end
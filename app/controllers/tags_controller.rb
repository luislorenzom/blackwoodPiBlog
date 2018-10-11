class TagsController < ApplicationController

    def index
        @query = params[:q]
        if @query.nil?
            render :json => Tag.all().map { |t| t.name }
        else
            render :json => Tag.where("name LIKE (?)", "#{@query}%").map { |t| t.name }
        end
    end
    
end
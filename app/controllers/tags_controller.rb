class TagsController < ApplicationController

  def show
    @tag_name = params[:name]
    @tag = Tag.where(:name => params[:name]).first
  end

end

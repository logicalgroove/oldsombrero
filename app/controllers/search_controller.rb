class SearchController < ApplicationController

  def index
    @tags_array = Tag.convert_to_tags(params[:search])
    @items = Item.search_by_tags_name(@tags_array)
  end

end

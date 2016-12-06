# DiariesController class
class DiariesController < ApplicationController
  def index
    @diaries = Diary.order_by(:fecha => 'desc')
  end

  def search_items
    @search = Item.es.search params[:search]
    @items = @search.results
  end
end

# DiariesController class
class DiariesController < ApplicationController
  def index
    @diaries = Diary.order_by(:fecha => 'desc')
  end

  def search_items
    @search = Item.es.search params[:search]
    if @search.results.empty?
      flash[:warning] = "No item found for #{params[:search]}"
      redirect_to action: 'index'
    else
      @items = @search.results
    end
  end
end

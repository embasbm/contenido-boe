# DiariesController class
class DiariesController < ApplicationController
  def index
    @diaries = Diary.order_by(:fecha => 'desc')
  end
end

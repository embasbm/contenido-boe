# DiariesController class
class DiariesController < ApplicationController
  def index
    @diaries = Diary.all.sort({fecha: -1})
  end
end

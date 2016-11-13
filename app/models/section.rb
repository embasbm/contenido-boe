# Section class
class Section
  include Mongoid::Document
  field :name, type: String
  field :number, type: String

  embedded_in :diary
  embeds_many :departments
end

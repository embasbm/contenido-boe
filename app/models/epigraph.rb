# Epigraph class
class Epigraph
  include Mongoid::Document
  field :name, type: String

  embedded_in :department
  embeds_many :items
end

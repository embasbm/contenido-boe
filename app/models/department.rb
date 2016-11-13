# Department class
class Department
  include Mongoid::Document
  field :name, type: String

  embedded_in :section
  embeds_many :items
  embeds_many :epigraphs
end

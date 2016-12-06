# Item class
class Item
  include Mongoid::Document
  include Mongoid::Elasticsearch
  elasticsearch!

  field :item_id, type: String
  field :title, type: String
  field :pdf_url, type: String

  embedded_in :department
  embedded_in :epigraph

end

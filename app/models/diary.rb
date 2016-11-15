# Diary class
class Diary
  include Mongoid::Document
  field :date_pub, type: String
  field :nbo, type: String
  field :pdf_url, type: String
  field :fecha, type: String

  embeds_many :sections
end

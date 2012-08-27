class Item
  include Mongoid::Document
  field :name, type: String
  field :price, type: Integer
  field :period, type: String
  field :description, type: String

  #relations
  belongs_to :user
end

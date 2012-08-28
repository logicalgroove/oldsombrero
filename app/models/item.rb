class Item
  include Mongoid::Document
  field :name, type: String
  field :price, type: Integer
  field :period, type: String
  field :description, type: String

  #relations
  belongs_to :user

  #validations
  validates :name, presence: true
  validates :price, presence: true
  validates :period, presence: true

end

class Item
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :price, type: Integer
  field :period, type: String
  field :description, type: String

  attr_accessible :name, :price, :period, :description, :tag_ids

  #relations
  belongs_to :user
  has_and_belongs_to_many :tags

  #validations
  validates :name, presence: true
  validates :price, presence: true
  validates :period, presence: true

  def tag_names
    tags.each_with_object('') do |tag, result|
      result << "##{tag.name} "
    end.strip
  end

end

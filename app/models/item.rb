class Item
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :price, type: Integer
  field :period, type: String
  field :description, type: String
  mount_uploader  :image, ImageUploader
  after_create :pull_to_following_users_feed

  attr_accessible :name, :price, :period, :description, :tag_ids, :image, :image_cache

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

  def self.search_by_tags_name(tags_array)
    tag_ids = Tag.where(:name.in => tags_array).collect {|t| t.id}
    tag_ids.empty? ? nil : where(:tag_ids.in => tag_ids)
  end

  def pull_to_following_users_feed
    pull_to_tags_followers
    pull_to_user_followers
  end

  def pull_to_tags_followers
    tags.each do |tag|
      tag.followers.each do |follower|
        follower.items << self
      end
    end
  end

  def pull_to_user_followers
    user.followers.each do |follower|
      follower.items << self
    end
  end

end

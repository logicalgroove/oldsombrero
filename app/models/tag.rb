class Tag
  include Mongoid::Document
  field :name, type: String

  #relations
  has_and_belongs_to_many :items

  def self.find_or_create_tags(tag_string)
    tag_names = tag_string.strip.downcase.gsub(/(?!#)\W/, ' ').gsub(/\s+#/, '#').gsub(/\s+/, '_').scan(/[\w'-]+/)
    tag_names.each_with_object([]) do |tag_name, tag_ids|
      tag_ids << self.find_or_create_by(:name => tag_name).id
    end
  end

end

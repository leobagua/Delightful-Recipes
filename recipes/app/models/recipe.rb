class Recipe < ContentfulModel::Base
  self.content_type_id = 'recipe'

  has_one :chef
  has_many :tags
end
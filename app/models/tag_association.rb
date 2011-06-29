class TagAssociation
  include MongoMapper::Document
  
  attr_accessible :users, :tags

  key :user_ids,  Array
  many :users,    :in => :user_ids

  key :tag_ids,   Array
  many :tags,     :in => :tag_ids

  timestamps!
end

class Tag
  include MongoMapper::Document

  key :tag,   String, :required => true
  key :count, Integer, :default => 1
end

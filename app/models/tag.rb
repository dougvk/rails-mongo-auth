class Tag
  include MongoMapper::Document
  # makes sure User not saved in mongo before validation
  safe

  attr_accessible :tag, :count

  validates :tag,       :uniqueness   => { :case_sensitive => false }

  key :tag,   String,   :required     => true
  key :count, Integer,  :default      => 1

  many :tag_associations

  Tag.ensure_index(:tag)
  Tag.ensure_index(:count)

  timestamps!
end

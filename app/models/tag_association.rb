class TagAssociation
  include MongoMapper::Document
  # makes sure User not saved in mongo before validation
  safe

  attr_accessible :user, :tag

  validates_associated :user
  validates_associated :tag

  belongs_to :user
  belongs_to :tag

  TagAssociation.ensure_index(:user)
  TagAssociation.ensure_index(:tag)

  timestamps!
end

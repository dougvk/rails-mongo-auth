class TagAssociation
  include MongoMapper::Document
  # makes sure User not saved in mongo before validation
  safe

  attr_accessible :user_id, :tag_id

  key :user_id, ObjectId
  key :tag_id, ObjectId

  TagAssociation.ensure_index(:user_id)
  TagAssociation.ensure_index(:tag_id)

  timestamps!
end

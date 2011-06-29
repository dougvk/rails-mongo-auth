class User
  include MongoMapper::Document

  # makes sure User not saved in mongo before validation
  safe

  attr_accessible :email, :password, :password_confirmation, :address, :title, :donor
  attr_accessor   :password

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates_presence_of :password,   :on => :create

  validates :email,     :format         => { :with => email_regex },
                        :uniqueness     => { :case_sensitive => false }

  validates :password,  :confirmation   => true,
                        :length         => { :within => 6..40 }

  validates_associated :address


  key :email,         String, :required => true
  key :password_hash, String
  key :password_salt, String
  key :title,         String, :required => true
  key :url,           String, :default  => nil
  one :address

  key :authorized_recipient Boolean, :default => false
  timestamps!

  User.ensure_index [[:email, 1]], :unique => true
  User.ensure_index([[:donor, 1], [:name, 1]])

  before_save :encrypt_password

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.password_salt == cookie_salt) ? user : nil
  end

  private

    def encrypt_password
      if password.present?
        self.password_salt = BCrypt::Engine.generate_salt
        self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
      end
    end

    def check_address
    end
end

class Address
  include MongoMapper::EmbeddedDocument

  validates_length_of :state, :is => 2

  key :address1, String,  :required => true
  key :address2, String
  key :city,     String,  :required => true
  key :state,    String,  :required => true
  key :zipcode,  String,  :required => true
end

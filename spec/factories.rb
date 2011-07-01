require 'factory_girl'

Factory.define :user do |f|
  f.sequence(:title) { |n| "foo#{n}" }
  f.email { |u| u.title + "@gmail.com" }
  f.password "password"
  f.password_confirmation { |u| u.password }
  f.association :address, :factory => :address
end

Factory.define :address do |f|
  f.city "Southport"
  f.state "CT"
  f.address1 "48 Harbor Road"
  f.zipcode "06890"
end

Factory.define :tag do |f|
  f.tag "foo#{rand(100000)}"
  f.count rand(100)
end

Factory.define :tag_association do |f|
  f.users [Factory.create(:user)]
  f.tags [Factory.create(:tag)]
end

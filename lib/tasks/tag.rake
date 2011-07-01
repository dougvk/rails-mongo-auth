require 'nokogiri'
require 'open-uri'

# TODO: JSON-ify tag list and export to ThriftDB
desc "Delete tag associations"
task :delete_tag_associations => :environment do
  user = User.find(ENV['USER_ID'])

  # find all associated TAs and Tags then remove/decrement them
  user_associations = TagAssociation.find_all_by_user_id(user.id)
  user_associations.each do |ta|
    tag = Tag.find_by_id(ta.tag_id)
    tag.decrement(:count => 1)
    ta.delete
  end
end

desc "Create tag associations"
task :create_tag_associations => :environment do
  sleep 10

  # find user to associate with
  user = User.find(ENV['USER_ID'])

  # query dmoz.org for tags
  url = "http://www.dmoz.org/search?q=" + ENV['USER_URL'] + "&start=0&type=more&all=no&cat="
  doc = Nokogiri::HTML(open(url))
  n = 0

  # get list of tag words separated by ": "
  res = doc.css('ol.dir li a').map { |link| [link.content, n+=1] }

  # no tags exist? Lame.
  if res == []
    return

  # parse out lame formatting
  res = res.select{|x| x[1] % 2 == 1}

  final_list = []
  res.each do |tags|
    # split on ": " and convert to lowercase
    tag_list = tags[0].split(': ').map {|x| x.downcase.split}

    # append each cleaned tag onto final_list
    tag_list.each{|x| x.each do |y| final_list << y end}
  end

  # for each tag, create the tag if it doesn't exist
  # then create an association between tag<->user
  final_list.uniq.each do |tag|
    tag = Tag.find_or_initialize_by_tag(tag)
    if not tag.created_at.nil?
      tag.increment(:count => 1)
    else
      tag.save
    end
    ta = TagAssociation.create!(:user_id => user.id, :tag_id => tag.id)
  end
end

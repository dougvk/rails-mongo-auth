ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  def teardown
    MongoMapper.database.collections.each do |coll|
      coll.remove
    end
  end

  def inherited(base)
    base.define_method teardown do
      super
    end
  end
end

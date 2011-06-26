MongoMapper.config = {
  "development" => { 'uri' => ENV['MONGOHQ_DEV_URL'] + "-#{Rails.env}" || 'mongodb:://localhost/sushi' },
  "production" => { 'uri' => ENV['MONGOHQ_PRO_URL'] + "-#{Rails.env}" || 'mongodb:://localhost/sushi' },
  "test" => { 'uri' => ENV['MONGOHQ_TEST_URL'] + "-#{Rails.env}" || 'mongodb:://localhost/sushi' }
}

MongoMapper.connect(Rails.env, { :logger => Rails.logger})

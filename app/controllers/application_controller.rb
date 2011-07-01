class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  def call_rake(task, options = {})
    options[:rails_env] ||= Rails.env
    args = options.map { |k, v| "#{k.to_s.upcase}='#{v}'" }
    system "rake #{task} #{args.join(' ')} -- trace 2&1 >> #{Rails.root}/log/#{Rails.env}.log &"
  end
end

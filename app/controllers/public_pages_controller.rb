class PublicPagesController < ApplicationController
  def home
    @title = "Home"
  end

  def about
    @title = "About"
  end
end

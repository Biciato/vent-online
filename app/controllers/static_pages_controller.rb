class StaticPagesController < ApplicationController
  def home
    render status: 503
  end

  def help
  end

  def about
  end

  def contact
  end
end

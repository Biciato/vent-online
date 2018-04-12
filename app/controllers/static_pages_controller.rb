class StaticPagesController < ApplicationController
  def home
    respond_to do |format|
      format.html { render :html => {:response => 'Service Unavailable' ,:status => 503 }}
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end

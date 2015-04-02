require 'post_fetcher'

class PagesController < ApplicationController
  before_action :authenticate_user!, except: :welcome
  def welcome
    redirect_to dashboard_path(current_user.site) if user_signed_in?
  end

  def front
    links = %w[
      http://phasezero.gawker.com/oigan-nsa-estamos-aqui-mismo-hijos-de-puta-1694745140/+LeahBeckmann#_ga=1.158786426.1708743908.1421266832
      http://defamer.gawker.com/can-you-believe-zayn-is-on-vacation-right-now-the-nerv-1695236646/+kellyconaboy
      http://gawker.com/the-sockman-and-me-encounters-with-a-friendly-neighbor-1693386262
    ]
    @posts = PostFetcher.get_posts(links)
  end

end

require 'post_fetcher'

class PostsController < ApplicationController
  def index
    links = %w[
      http://phasezero.gawker.com/oigan-nsa-estamos-aqui-mismo-hijos-de-puta-1694745140/+LeahBeckmann#_ga=1.158786426.1708743908.1421266832
      http://defamer.gawker.com/can-you-believe-zayn-is-on-vacation-right-now-the-nerv-1695236646/+kellyconaboy
      http://gawker.com/the-sockman-and-me-encounters-with-a-friendly-neighbor-1693386262
    ]
    @posts = PostFetcher.get_posts(links)
  end

  def show
    link = "http://phasezero.gawker.com/oigan-nsa-estamos-aqui-mismo-hijos-de-puta-1694745140/"
    @post = PostFetcher.get_post(link)
  end
end

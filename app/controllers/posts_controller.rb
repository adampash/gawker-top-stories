require 'post_fetcher'

class PostsController < ApplicationController
  def index
    links = FrontPage.latest(params[:site])
    links[0] = "http://phasezero.gawker.com/oigan-nsa-estamos-aqui-mismo-hijos-de-puta-1694745140/"
    @posts = PostFetcher.get_posts(links)
  end

  def show
    link = "http://phasezero.gawker.com/oigan-nsa-estamos-aqui-mismo-hijos-de-puta-1694745140/"
    @post = PostFetcher.get_post(link)
  end
end

require 'post_fetcher'

class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:get_links]
  def index
    unless current_user.site == params[:site]
      redirect_to dashboard_path(current_user.site)
    end
    links = FrontPage.latest(params[:site])
    @posts = PostFetcher.get_posts(links)
  end

  def show
    @post = PostFetcher.get_post(params[:url])
  end

  def create
    FrontPage.create(
      first: params[:first],
      second: params[:second],
      third: params[:third],
      site: current_user.site,
      user_id: current_user.id,
    )
    render json: {success: true}
  end

  def get_links
    @links = FrontPage.latest(params[:site])
    render json: @links.to_json
  end
end

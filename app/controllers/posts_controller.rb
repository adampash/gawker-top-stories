require 'post_fetcher'

class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:get_links]
  def index
    unless current_user.site == params[:site] or current_user.admin?
      redirect_to dashboard_path(current_user.site)
    end
    post_ids = FrontPage.latest(params[:site])
    @posts = post_ids.map do |post_id|
      if post_id.nil?
        nil
      else
        Post.find(post_id.to_i)
      end
    end
    @posts
  end

  def show
    post = PostFetcher.get_post(params[:url])
    @post = Post.find_or_create(post)
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

  def update_deck
    @post = Post.find(params[:id])
    @post.update_attributes deck: params[:deck]
    @post
  end

  def get_links
    @links = FrontPage.latest(params[:site])
    render json: @links.to_json
  end

  def embed
    post_ids = FrontPage.latest(params[:site])
    @posts = post_ids.map do |post_id|
      Post.find(post_id.to_i)
    end
    @posts
    render layout: 'embed'
  end
end

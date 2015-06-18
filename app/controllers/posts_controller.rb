require 'post_fetcher'

class PostsController < ApplicationController
  before_filter :set_cache_control_headers, only: [:embed]
  after_action :allow_iframe, only: :embed

  before_action :authenticate_user!, except: [:get_links, :embed]
  def index
    unless current_user.site == params[:site] or current_user.admin?
      redirect_to dashboard_path(current_user.site)
    end
    @front_page = FrontPage.latest(params[:site])
    post_ids = @front_page.nil? ? [nil, nil, nil] : @front_page.get_links
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
    unless current_user.site == params[:site] or current_user.admin?
      redirect_to dashboard_path(current_user.site)
    end
    @old_front = FrontPage.latest(params[:site])
    FrontPage.create(
      first: params[:first],
      second: params[:second],
      third: params[:third],
      site: params[:site],
      user_id: current_user.id,
      title: params[:title],
    )
    @old_front.purge
    render json: {success: true}
  end

  def update_deck
    @post = Post.find(params[:id])
    @post.update_attributes deck: params[:deck]
    @post.purge
    @post.purge_all
    @post
  end

  def get_links
    @links = FrontPage.latest(params[:site]).get_links
    render json: @links.to_json
  end

  def embed
    @front_page = FrontPage.latest(params[:site])
    post_ids = @front_page.get_links
    @posts = post_ids.map do |post_id|
      Post.find(post_id.to_i)
    end
    @posts
    set_surrogate_key_header [@front_page.record_key, @posts.map(&:record_key)].flatten
    render layout: 'embed'
  end
  private
  def allow_iframe
    response.headers.except! 'X-Frame-Options'
  end

end

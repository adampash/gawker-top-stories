require 'kinja'

module PostFetcher
  def self.get_posts(links)
    links.map do |link|
      get_post link
    end
  end

  def self.get_post(link)
    return nil if link.nil?
    post = kinja.get_post(link)["data"]
    post.slice("headline", "permalink", "leftOfHeadline")
  end

  protected
  def self.kinja
    Kinja::Client.new
  end

end

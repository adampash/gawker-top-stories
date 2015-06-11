class Post < ActiveRecord::Base
  def self.find_or_create(params)
    # require 'pry'; binding.pry
    post = find_by(kinja_id: params["id"])
    if post.nil?
      create(
        kinja_id: params["id"],
        tags: params["tags"],
        image: params["leftOfHeadline"],
        permalink: params["permalink"],
        deck: nil,
        headline: params["headline"],
      )
    end
    post
  end
end

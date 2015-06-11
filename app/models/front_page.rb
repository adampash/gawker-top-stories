class FrontPage < ActiveRecord::Base
  belongs_to :user
  def self.latest(site)
    where(site: site).order('created_at DESC').first
  end

  def get_links
    [first, second, third]
  end

end

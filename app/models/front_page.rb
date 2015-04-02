class FrontPage < ActiveRecord::Base
  belongs_to :user
  def self.latest(site)
    page = where(site: site).order('created_at DESC').first
    page.nil? ? [] : page.get_links
  end

  def get_links
    [first, second, third]
  end

end

class FrontPage < ActiveRecord::Base
  def self.latest(site)
    %w[
      http://phasezero.gawker.com/oigan-nsa-estamos-aqui-mismo-hijos-de-puta-1694745140/+LeahBeckmann#_ga=1.158786426.1708743908.1421266832
      http://defamer.gawker.com/can-you-believe-zayn-is-on-vacation-right-now-the-nerv-1695236646/+kellyconaboy
      http://gawker.com/the-sockman-and-me-encounters-with-a-friendly-neighbor-1693386262
    ]
    page = where(site: site).order('created_at DESC').first
    page.nil? ? [] : page.get_links
  end

  def get_links
    [first, second, third]
  end

end

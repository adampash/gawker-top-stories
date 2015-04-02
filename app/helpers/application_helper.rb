module ApplicationHelper
  PAIRS = {
    "deadspin" => "Deadspin",
    "gawker" => "Gawker",
    "gizmodo" => "Gizmodo",
    "io9" => "io9",
    "jalopnik" => "Jalopnik",
    "jezebel" => "Jezebel",
    "kotaku" => "Kotaku",
    "lifehacker" => "Lifehacker"
  }

  def site_header(site)
    raw "<h1 class=\"site\">#{ PAIRS[site] } Top Stories</h1>"
  end

end

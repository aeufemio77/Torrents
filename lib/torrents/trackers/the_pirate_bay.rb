module Trackers
  class ThePirateBay
    def details(tr)
      "http://thepiratebay.se" + tr.at_css('.detLink').attr('href')
    end
  
    def torrent(tr)
      tr.to_s.match(/(http:\/\/.+\.torrent)/).to_a[1]
    end
  
    def title(tr)
      tr.at_css('.detLink').content
    end
  
    def seeders(details)
      details.to_s.match(/.+<dd>(\d+)<\/dd>/).to_a[1]
    end
    
    def torrents(site)
      site.css('#searchResult tr')
    end
    
    def search_url
      "http://thepiratebay.se/search/<SEARCH>/<PAGE>/99/0"
    end
    
    def recent_url
      "http://thepiratebay.se/recent/<PAGE>"
    end
    
    def start_page_index
      0
    end
    
    def category_url(type)
      {:movies => "http://thepiratebay.se/browse/201/<PAGE>/3"}[type]
    end
    
    def id(details)
      details.to_s.match(/\/(\d+)\//).to_a[1]
    end
    
    def details_title(details)
      details.at_css('#title').content
    end
    
    def details_torrent(details)
      self.torrent(details) # The same parsing algorithm as the torrent method
    end
  end
end

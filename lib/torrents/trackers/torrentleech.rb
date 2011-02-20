module Trackers
  class Torrentleech
    def details(tr)
      "http://torrentleech.org" + tr.at_css('.title a').attr('href')
    end
  
    def torrent(tr)
      "http://torrentleech.org" + tr.at_css('td.quickdownload a').attr('href')
    end
  
    def title(tr)
      tr.at_css('.title a').content
    end
  
    def seeders(details)
      details.to_s.match(/\((\d+) Seeders and \d+ leechers\)/).to_a[1]
    end
    
    def torrents(site)
      site.css('#torrenttable tr')
    end
    
    def search_url
      "http://www.torrentleech.org/torrents/browse/index/query/<SEARCH>/page/<PAGE>"
    end
    
    def recent_url
      "http://www.torrentleech.org/torrents/browse/index/page/<PAGE>"
    end
    
    def start_page_index
      1
    end
    
    def category_url(type)
      {:movies => "http://www.torrentleech.org/torrents/browse/index/categories/1,8,9,10,11,12,13,14,15,29/page/<PAGE>"}[type]
    end
  end
end
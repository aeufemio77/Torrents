describe Trackers::Tti do  
  def rest_client(url, type)
    RestClient.should_receive(:get).with(url, {:timeout => 10, :cookies => cookies}).any_number_of_times.and_return(File.read("spec/data/tti/#{type}.html"))
  end
  
  def cookies
    authentication["cookies"]
  end
  
  def authentication
    YAML::load(File.read("authentication/tti.yaml"))
  end
  
  def create_torrent
    Container::Torrent.new({
      details: "http://tti.nu/details.php?id=132470", 
      torrent: "http://tti.nu/download2.php/132230/Macbeth.2010.DVDRip.XviD-VoMiT.torrent", 
      title: "The title", 
      tracker: "Tti",
      cookies: cookies
    })
  end
  
  it "should only list torrents with the right title" do
    rest_client("http://tti.nu/browse.php?search=dvd&page=0&incldead=0", "search")
    torrents = Torrents.tti.cookies(cookies).search("dvd")
    
    torrents.results.each do |torrent|
      torrent.title.should_not eq(torrent.torrent)
    end
    
    torrents.should have(50).results
  end
  
  it "should be possible to parse the details view" do
    rest_client("http://tti.nu/details.php?id=132470", "details")
    torrent = create_torrent
    
    torrent.should be_valid    
    torrent.seeders.should eq(70)
  end

  it "should be possible to list recent torrents" do
    rest_client("http://tti.nu/browse.php?page=0&incldead=0", "recent")
    Torrents.tti.cookies(cookies).should have(50).results
  end
  
  it "should found 50 recent movies" do
    rest_client("http://tti.nu/browse.php?c47=1&c65=1&c59=1&c48=1&page=0&incldead=0", "movies")
    Torrents.tti.cookies(cookies).category(:movies).should have(50).results
  end
end
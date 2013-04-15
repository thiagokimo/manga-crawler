require "test_helper"

describe MangaCrawler::Crawler do
  
  it "must get mangas" do
    crawler = MangaCrawler::Crawler.new

    sample_index = File.open("test/samples/index-page.html")
    css_path = "a"
    html_field = :href
    
    mangas = crawler.get_mangas sample_index, css_path, nil, html_field

    mangas.must_equal [ ["Naruto", "/first-manga"], ["Bleach", "/second-manga"], ["One Piece", "/third-manga"] ]
  end
end
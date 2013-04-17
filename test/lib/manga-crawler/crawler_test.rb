require "test_helper"

describe MangaCrawler::Crawler do

  crawler = MangaCrawler::Crawler.new
  base_url = "localhost"
  
  it "must retrieve mangas" do

    
    sample_index_page = File.open("test/samples/index-page.html")
    css_path = "a"
    html_field = :href

    index_page_parameters = Website::Parameters.new(base_url, sample_index_page, css_path, html_field)
    index_page = Website::Page.new(index_page_parameters)
    
    mangas = crawler.get_mangas index_page

    mangas.must_equal [ ["Naruto", "/first-manga"], 
                        ["Bleach", "/second-manga"], 
                        ["One Piece", "/third-manga"] ]
  end

  it "must retrieve chapters" do
    
    sample_manga_page = File.open("test/samples/manga-page.html")
    css_path = "a"
    html_field = :href

    chapters_page_parameters = Website::Parameters.new(base_url, sample_manga_page, css_path, html_field)
    manga_page = Website::Page.new(chapters_page_parameters)

    chapters = crawler.get_chapters manga_page

    chapters.must_equal [ ["Chapter 1", "/first-manga/1"], 
                          ["Chapter 2", "/second-manga/2"], 
                          ["Chapter 3", "/third-manga/3"] ]
  end

  it "must retrieve a direct image link from a page" do
    
    sample_image_page = File.open("test/samples/image-page.html")
    css_path = "#img"
    html_field = :src

    image = crawler.get_image_from_page sample_image_page, css_path, html_field

    image.must_equal "image.jpg"
  end

  it "must retrieve all pages links from a chapter" do

    sample_image_page = File.open("test/samples/image-page.html")
    css_path = "#pageMenu option"
    html_field = :value
    
    pages_links = crawler.get_pages_links_from_chapter sample_image_page, css_path, html_field

    pages_links.must_equal [ ["1", "/first-manga/1/1"],
                             ["2", "/first-manga/1/2"], 
                             ["3", "/first-manga/1/3"] ]

  end
end
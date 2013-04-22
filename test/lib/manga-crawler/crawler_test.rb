require "test_helper"

describe MangaCrawler::Crawler do

  crawler = MangaCrawler::Crawler.new
  base_url = "localhost"

  it "must retrieve mangas" do

    sample_index_page = File.open("test/fixtures/index.html")
    css_path = "a"
    html_field = :href

    params = Website::Parameters.new(base_url, sample_index_page, css_path, html_field)
    index_page = Website::Page.new(params)
    
    mangas = crawler.get_mangas index_page

    mangas.must_equal [ ["Naruto", "Naruto/naruto.html"], 
                        ["Bleach", "Bleach/bleach.html"], 
                        ["One Piece", "OnePiece/one_piece.html"] ]
  end

  it "must retrieve chapters" do
    
    sample_manga_page = File.open("test/fixtures/Bleach/bleach.html")
    css_path = ".download-link"
    html_field = :href

    params = Website::Parameters.new(base_url, sample_manga_page, css_path, html_field)
    manga_page = Website::Page.new(params)

    chapters = crawler.get_chapters manga_page

    chapters.must_equal [ ["Bleach chapter 1", "chapters/1/1.html"], 
                          ["Bleach chapter 2", "chapters/2/1.html"], 
                          ["Bleach chapter 3", "chapters/3/1.html"] ]
  end

  it "must retrieve a direct image link from a page" do
    
    sample_image_page = File.open("test/fixtures/naruto/chapters/1/1.html")
    css_path = "#img"
    html_field = :src

    params = Website::Parameters.new(base_url, sample_image_page, css_path, html_field)
    image_page = Website::Page.new(params)

    image = crawler.get_image_from_page image_page

    image.must_equal "duck.jpg"
  end

  it "must retrieve all pages links from a chapter" do

    sample_image_page = File.open("test/fixtures/OnePiece/chapters/2/1.html")
    css_path = "#page_switch option"
    html_field = :value

    params = Website::Parameters.new(base_url, sample_image_page, css_path, html_field)
    pages = Website::Page.new(params)
    
    pages_links = crawler.get_pages_links_from_chapter pages

    pages_links.must_equal [ ["1", "1.html"], ["2", "2.html"] ]

  end

  it "must collect all pages from a given chapter" do
    
    link = "test/fixtures/Bleach/chapters/1/1.html"
    sample_chapter_page = File.open(link)

    base_url = File.absolute_path(sample_chapter_page).gsub(/test\/fixtures\/Bleach\/chapters\/1\/1.html/,"")

    css_pages_path = "#page_switch option"
    pages_html_field = :value

    params = Website::Parameters.new(base_url, link, css_pages_path, pages_html_field)
    chapter_page = Website::Page.new(params)

    pages = crawler.get_pages chapter_page, "#img"

    pages.must_equal ["mushroom_risotto.jpg", "vegetable_curry.jpg"]
  end
end
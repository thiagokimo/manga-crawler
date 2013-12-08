require_relative "../../test_helper"

module MangaCrawler
  describe Crawler do

    before do
      @url = File.open("test/sample_website/index.html","r")
      @base_url = "test/sample_website/"
      @sample_manga_page = File.open("test/sample_website/Bleach/bleach.html","r") 
      @css_path_to_mangas = "a"
      @css_path_to_chapters = ".download-link"
      @chapter_page = File.open("test/sample_website/Bleach/chapters/1/1.html")
      @css_path_to_pages = "#page_switch option"
      @css_path_to_image = "#img"
      @image_attr = :src
    end

    it "must get all mangas from a website" do
      crawler = Crawler.new @base_url

      expected_manga_urls = [
                              ["Naruto", "Naruto/naruto.html"],
                              ["Bleach", "Bleach/bleach.html"],
                              ["One Piece", "OnePiece/one_piece.html"]
                            ]

      crawler.get_mangas(@url, @css_path_to_mangas).must_equal expected_manga_urls
    end

    it "must retrieve the chapters of a manga page" do
      crawler = Crawler.new @base_url

      expected_chapters = [
                              ["Bleach chapter 1", "chapters/1/1.html"],
                              ["Bleach chapter 2", "chapters/2/1.html"],
                              ["Bleach chapter 3", "chapters/3/1.html"]
                            ]

      crawler.get_chapters(@sample_manga_page, @css_path_to_chapters).must_equal expected_chapters
    end

    it "must retrieve the pages of a chapter" do
      crawler = Crawler.new @base_url
      expected_pages = ["mushroom_risotto.jpg", "vegetable_curry.jpg"]
      
      crawler.get_pages(@chapter_page, @css_path_to_pages, @css_path_to_image, @image_attr).must_equal expected_pages
    end
  end
end



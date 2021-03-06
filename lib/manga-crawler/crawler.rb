require 'nokogiri'
require 'open-uri'

module MangaCrawler
  class Crawler
    
    def initialize(base_url)
      @base_url = base_url
    end

    def get_mangas(mangas_url, css_path_to_mangas)
      get_content(fix_url(mangas_url),css_path_to_mangas, :href)
    end
    
    def get_chapters(manga_url, css_path_to_chapters)
      get_content(fix_url(manga_url), css_path_to_chapters, :href)
    end

    def get_pages(chapter_url, css_path_to_pages, css_path_to_image, image_attr)
      pages_elements = get_content(fix_url(chapter_url), css_path_to_pages, :value)

      pages_elements.collect do |page|
        get_content(fix_url(page[1]), css_path_to_image, image_attr).first[1]
      end
    end
    
    private
    def get_content(url, css, attr)
      html = Nokogiri::HTML(open(url))

      content = html.css(css)
      content.collect do |e|
        [e.text, e[attr]]
      end
    end
    def fix_url(url)
      if url.include? @base_url
        url
      else
        create_complete_url(url)
      end
    end

    def create_complete_url(partial_url)
      @base_url + partial_url
    end
  end
end


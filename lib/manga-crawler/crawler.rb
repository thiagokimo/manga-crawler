require 'nokogiri'
require 'open-uri'

module MangaCrawler
  class Crawler

    def get_mangas index_website

      result = Array.new

      html_index = Nokogiri::HTML(open(index_website.params.current_url))

      #find all content that matches with the css_path
      links = html_index.css(index_website.params.css_path)

      #find all content from the anchor nodes found in last search
      links.each do |anchor|
        result.push([anchor.content, anchor[index_website.params.html_field]])
      end

      #TODO
      #if has a css_pagination, use recursion
      #example: result += get_mangas next_link, css_path, css_pagination

      return result
    end

    def get_chapters manga_website
      #TODO
      #uses the same logic of get_mangas
      return get_mangas manga_website
    end

    # Returns the direct links of all pages from a specific chapter. It uses two
    # methods: 'get_pages_links_from_chapter' and 'get_image_from_page'.
    # Params:
    # +chapter_link+:: string with the chapter
    # +css_pages_path+:: string with the CSS path to the pages links
    # +pages_html_field+:: HTML field with the page link value
    # +css_image_path+:: CSS path to the image
    # +image_html_field+:: HTML field with the direct's image url
    # +url_base+:: Site´s base url
    def get_pages chapter_website, image_website
      
      result = Array.new

      pages_links = get_pages_links_from_chapter chapter_website.params.base_url + chapter_website.params.current_url, 
                                                  chapter_website.params.css_path, chapter_website.params.html_field

      pages_links.each do |page|
        result.push( get_image_from_page image_website.params.base_url + page[1], image_website.params.css_path, 
                                                                                    image_website.params.html_field )
      end

      return result

    end

    def get_pages_links_from_chapter chapter_website

      result = Array.new

      chapter_page = Nokogiri::HTML(open(chapter_website.params.current_url))

      pages_links = chapter_page.css(chapter_website.params.css_path)

      pages_links.each do |option|
        result.push([option.content, option[chapter_website.params.html_field]])
      end

      return result
    end

    def get_image_from_page image_website

      html_image = Nokogiri::HTML(open(image_website.params.current_url))

      image_link = html_image.at_css(image_website.params.css_path)[image_website.params.html_field]

      return image_link
    end
  end
end


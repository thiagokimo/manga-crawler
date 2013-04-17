require 'nokogiri'
require 'open-uri'

module MangaCrawler
  class Crawler

    # Returns an array of pairs. The first position contains the 
    # manga name and the second position the manga link
    # Params:
    # +index_link+:: string with the url containing the index of all mangas
    # +css_path+:: string of a css path format of the links you want to collect
    # +css_pagination+:: string with the css path to the next page link
    # +html_field+:: simbol of the field that has the link
    def get_mangas index_link, css_path, css_pagination, html_field

      result = Array.new

      html_index = Nokogiri::HTML(open(index_link))

      #find all content that matches with the css_path
      links = html_index.css(css_path)

      #find all content from the anchor nodes found in last search
      links.each do |anchor|
        result.push([anchor.content, anchor[html_field]])
      end

      #TODO
      #if has a css_pagination, use recursion
      #example: result += get_mangas next_link, css_path, css_pagination

      return result
    end

    # Returns the chapters information of a manga. It uses the same
    # logic of get_mangas.
    # Params:
    # +manga_link+:: string with the url containing the manga_link
    # +css_path+:: string of the css path format of the links you want to collect
    # +css_pagination+:: string with the css path to the next page link
    # +html_field+:: simbol of the field that has the link 
    def get_chapters manga_link, css_path, css_pagination, html_field
      #TODO
      #uses the same logic of get_mangas
      return get_mangas manga_link, css_path, css_pagination, html_field
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
    def get_pages chapter_link, css_pages_path, pages_html_field, css_image_path, image_html_field, url_base
      
      result = Array.new

      pages_links = get_pages_links_from_chapter url_base + chapter_link, css_pages_path, pages_html_field

      pages_links.each do |page|
        result.push( get_image_from_page url_base + page[1], css_image_path, image_html_field )
      end

      return result

    end

    # Returns all pages HTML links from a chapter
    # Params:
    # +chapter_link+:: Link of the chapter
    # +css_path+:: CSS path to the block with the pages links
    # +html_field+:: HTML field that contains the url
    def get_pages_links_from_chapter chapter_link, css_path, html_field

      result = Array.new

      chapter_page = Nokogiri::HTML(open(chapter_link))

      pages_links = chapter_page.css(css_path)

      pages_links.each do |option|
        result.push([option.content, option[html_field]])
      end

      return result
    end

    # Returns the image's direct url of a manga page
    # Params:
    # +page_link+:: HTML page who contains the image
    # +css_path+:: CSS path to the image
    # +html_field+:: field that contains the url
    def get_image_from_page page_link, css_path, html_field

      html_image = Nokogiri::HTML(open(page_link))

      image_link = html_image.at_css(css_path)[html_field]

      return image_link
    end
  end
end

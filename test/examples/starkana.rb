require File.expand_path('../../../lib/manga-crawler.rb', __FILE__) # require MangaCrawler

# http://www.starkana.com

URL = "http://www.starkana.com"
crawler = MangaCrawler::Crawler.new URL

# collecting mangas
MANGAS_URL = "http://www.starkana.com/manga/list"
mangas_css = "#inner_page a:nth-child(2)"

mangas = crawler.get_mangas(MANGAS_URL, mangas_css)

puts "There are #{mangas.length} mangas in Starkana"

puts "Picking a random manga..."
random_number = (0..mangas.length-1).to_a.sample
random_manga = mangas[random_number]

puts "The random manga is #{random_manga[0]}"

# colleting chapters from a manga
css_path_to_chapters = ".download-link"
manga_url = URL + random_manga[1] + "?mature_confirm=1"
chapters = crawler.get_chapters(manga_url, css_path_to_chapters).reverse

puts "#{random_manga[0]} has #{chapters.length} chapters"
if chapters.length > 0

  puts "Picking a random chapter..."
  random_chapter_number = (0..chapters.length-1).to_a.sample
  random_chapter = chapters[random_chapter_number]
  
  puts "Collecting pages from #{random_chapter[0]}"

  # collecting pages from a chapter
  chapter_url = URL + random_chapter[1]
  css_pages_path = "#page_switch option"
  css_image_path = "#pic img"
  pages = crawler.get_pages(chapter_url, css_pages_path, css_image_path, :src)

  puts "There are #{pages.length}"

  p pages
end


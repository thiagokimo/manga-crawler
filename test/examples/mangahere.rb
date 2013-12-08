require File.expand_path('../../../lib/manga-crawler.rb', __FILE__) #require MangaCrawler

# www.mangahere.com 

URL = "http://www.mangahere.com"
crawler = MangaCrawler::Crawler.new URL

# collecting mangas
MANGAS_URL = "http://www.mangahere.com/mangalist/"
mangas_css = ".manga_info"

mangas = crawler.get_mangas(MANGAS_URL, mangas_css)

puts "There are #{mangas.length} mangas in Manga Here"

puts "Picking a random manga..."
random_number = (0..mangas.length-1).to_a.sample
random_manga = mangas[random_number]

puts "The random manga is #{random_manga[0]}"

# collecting chapters from a manga
css_path_to_chapters = ".detail_list .color_0077"
manga_url = random_manga[1]
chapters = crawler.get_chapters(manga_url, css_path_to_chapters).reverse

puts "#{random_manga[0]} has #{chapters.length} chapters"
puts "Picking a random chapter..."

random_chapter_number = (0..chapters.length-1).to_a.sample
random_chapter = chapters[random_chapter_number]

puts "Collecting pages from chapter #{random_chapter[0]}"

# collecting pages from a chapter
chapter_url = random_chapter[1]
css_pages_path = ".go_page .wid60 option"
css_image_path = "#image"
pages = crawler.get_pages(chapter_url, css_pages_path, css_image_path, :src)

puts "There are #{pages.length} pages"

p pages

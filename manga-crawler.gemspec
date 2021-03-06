# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'manga-crawler/version'

Gem::Specification.new do |spec|
  spec.name          = "manga-crawler"
  spec.version       = MangaCrawler::VERSION
  spec.authors       = ["Thiago Rocha"]
  spec.email         = ["kimo@kimo.io"]
  spec.description   = %q{ A gem that collects mangas from websites}
  spec.summary       = %q{ Retrieve basic manga information }
  spec.homepage      = "https://github.com/thiagokimo/manga-crawler"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_dependency "nokogiri"
end

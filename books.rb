#!/usr/bin/env ruby

$LOAD_PATH.unshift(File.expand_path('../lib', __FILE__))
BOOKS_FILE = File.expand_path("../books.csv", __FILE__)
require 'books'
require 'optparse'

options = {}
OptionParser.new do |opts|
  opts.banner = <<-MSG
Search books by different attributes
Usage: books.rb [options]
MSG

  opts.on('-a', '--author AUTHOR', 'List books written by author') do |author|
    options[:author] = author
  end

  opts.on('-l', '--language LANGUAGE', 'List books written in language') do |language|
    options[:language] = language
  end

  opts.on('-p', '--publisher PUBLISHER', 'List books published by publisher') do |publisher|
    options[:publisher] = publisher
  end

  opts.on('-t', '--title TITLE', 'List books with title') do |title|
    options[:title] = title
  end
end.parse!

def fail(message)
  STDERR.puts(message)
  exit 1
end

parser = Books::CsvParser.new(BOOKS_FILE)
database = parser.parse
book_candidates = []
if options[:author]
  author = database.table(:authors).search(:name => options[:author]).first
  fail("Author #{options[:author]} not found") unless author
  book_candidates << author.books
end

if options[:language]
  language = database.table(:languages).search(:language => options[:language]).first
  fail("Language #{options[:language]} not found") unless language
  book_candidates << language.books
end

if options[:publisher]
  publisher = database.table(:publishers).search(:publisher => options[:publisher]).first
  fail("Publisher #{options[:publisher]} not found") unless publisher
  book_candidates << publisher.books
end

if options[:title]
  book_candidates << database.table(:books).search(:title => options[:publisher])
end

books = book_candidates.reduce(&:&)
books.each do |book|
  puts "#{book.authors.map(&:name).join(', ')} (#{book.year}): #{book.title}"
end

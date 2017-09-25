# encoding: utf-8

require 'minitest/autorun'

describe 'books.rb' do
  def books(args)
    `ruby books.rb #{args}`
  end

  it 'filters by author' do
    books = self.books('-a "Karel Čapek"')
    expected_books = <<BOOKS
Guillaume Apollinaire, Karel Čapek, Adolf Kroupa, Milan Kundera (1965): Alkoholy života
Karel Čapek (1924): Anglické listy
Karel Čapek (1925): Anglické listy
Karel Čapek (1947): Anglické listy
Karel Čapek (1970): Anglické listy
Karel Čapek, Norma Comrada (1997): Apocryphal tales
Karel Čapek (1932): Apokryfy.
Karel Čapek, Lawrence Hyde (1948): An atomic phantasy
Karel Čapek (1988): Aus der einen Tasche in die andere
Karel Čapek, Anna Auředníčková (1976): Das Absolutum, oder, Die Gottesfabrik
Karel Čapek (1961): Bajky a podpovídky.
BOOKS
    books.lines.sort.must_equal expected_books.lines.sort
  end

  it 'filters by author and language' do
    books = self.books('-a "Karel Čapek" -l eng')
    expected_books = <<BOOKS
Karel Čapek, Norma Comrada (1997): Apocryphal tales
Karel Čapek, Lawrence Hyde (1948): An atomic phantasy
BOOKS
    books.lines.sort.must_equal expected_books.lines.sort
  end

  it 'filters by author and language and publisher' do
    books = self.books('-a "Karel Čapek" -l eng -p "Catbird Press"')
    expected_books = <<BOOKS
Karel Čapek, Norma Comrada (1997): Apocryphal tales
BOOKS
    books.lines.sort.must_equal expected_books.lines.sort
  end
end

module Books
  class Author < Record
    attrs :id, :name, :search_name
    has_many :books
  end

  class Book < Record
    attrs :id, :title, :year
    has_many :authors
    belongs_to :language
    belongs_to :publisher
  end

  class Language < Record
    attrs :id, :language
    has_many :books
  end

  class Publisher < Record
    attrs :id, :publisher
    has_many :books
  end

  class BookAuthor < Record
    def add_links(database)
      super
      book = database.table(:books).search(:id => @data['book_id']).first
      author = database.table(:authors).search(:id => @data['author_id']).first
      book.authors << author
      author.books << book
    end
  end
end

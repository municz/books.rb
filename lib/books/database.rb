module Books
  class DatabaseTable
    attr_reader :name, :klass, :data

    def initialize(database, name, klass)
      @database = database
      @name = name
      @klass = klass
      @data = {}
    end

    def add_record(data)
      record = klass.new(data)
      @data[record.id.to_i] = record
    end

    def add_links
      @data.values.each { |record| record.add_links(@database) }
    end

    def search(conditions)
      if conditions.keys.map(&:to_s) == ['id']
        id = (conditions[:id] || conditions['id']).to_i
        [@data.fetch(id)].compact
      else
        @data.values.select { |record| conditions.all? { |key, value| record.data[key.to_s] == value } }
      end
    end
  end

  class Database
    TABLE_MAPPING = {
      authors: Author,
      books: Book,
      languages: Language,
      publishers: Publisher,
      books_authors: BookAuthor
    }

    def initialize
      @tables = {}
      TABLE_MAPPING.each do |name, klass|
        @tables[name] = DatabaseTable.new(self, name, klass)
      end
      @valid_tables = TABLE_MAPPING.keys + TABLE_MAPPING.keys.map(&:to_s)
    end

    def add_record(type, data)
      table(type).add_record(create_record(type, data))
    end

    def table(name)
      validate_table!(name)
      @tables.fetch(name.to_sym)
    end

    def add_links
      @tables.values.each(&:add_links)
    end

    private

    def validate_table!(table)
      raise "Unknown table #{table}" unless @valid_tables.include?(table)
    end
  end
end

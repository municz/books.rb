module Books
  class CsvParser
    def initialize(file)
      @file = file
    end

    def parse
      database = Database.new
      each_csv do |table, csv|
        csv_to_hashes(csv).each do |data|
          database.table(table).add_record(data)
        end
      end
      database.add_links
      database
    end

    private

    # Slice the content of the input by the '====== table ======' patten
    # and yields type and corresponding csv part
    def each_csv
      sliced_lines = File.read(@file).lines.slice_before(/^====== .* ======$/)
      sliced_lines.each do |batch|
        header, *lines = batch
        type = header[/====== (.*) ======/, 1]
        raise "Unexpected header #{header}" unless type
        csv = lines.join
        yield type, csv
      end
    end

    # Takes csv (including head
    def csv_to_hashes(csv)
      CSV.parse(csv, :headers => true).map(&:to_hash)
    end
  end
end

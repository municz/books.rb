module Books
  class Inflector
    def self.instance
      @instance ||= self.new
    end

    def singularize(string)
      string.sub(/s$/, '')
    end

    def pluralize(string)
      "#{string}s"
    end

    # turn CamelCase to camel_case
    def underscore(string)
      return string if string.empty?
      unless string =~ /\A[A-Z]/
        string = string.dup
        string[0] = string[0].upcase
      end
      string.scan(/[A-Z][a-z]*/).map(&:downcase).join("_")
    end
  end
end

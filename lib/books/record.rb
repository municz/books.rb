module Books
  class Record
    attr_reader :data

    def initialize(data)
      @data = data
    end

    def to_s
      "#{self.class.name}: #{@data.inspect}}"
    end

    def inspect
      "#{self.class.name}: #{@data.inspect}}"
    end

    def id
      @data['id']
    end

    def add_links(database)
      self.class.reflection[:belongs_to].each do |association|
        foreign_id = @data["#{association}_id"]
        next unless foreign_id
        associated_object = database.table(inflector.pluralize(association)).search(id: foreign_id).first
        self.send("#{association}=", associated_object)
        opposite_association = inflector.pluralize(self.class.table_name)
        associated_object.send(opposite_association) << self
      end
    end

    private

    def inflector
      Inflector.instance
    end

    class << self
      def table_name
        Inflector.instance.underscore(name[/\w+$/])
      end

      def reflection
        @reflection ||= { :attrs => [], :belongs_to => [], :has_many => [] }
      end

      def attrs(*attrs)
        reflection[:attrs].concat(attrs)
        attrs.each do |attr|
          define_method(attr) do
            @data[attr.to_s]
          end
        end
      end

      def belongs_to(attr)
        reflection[:belongs_to] << attr
        define_method(attr) do
          instance_variable_get("@#{attr}")
        end

        define_method("#{attr}=") do |value|
          instance_variable_set("@#{attr}", value)
        end
      end

      def has_many(attr)
        reflection[:has_many] << attr
        define_method(attr) do
          instance_variable_get("@#{attr}") || instance_variable_set("@#{attr}", [])
        end

        define_method("#{attr}=") do |value|
          instance_variable_set("@#{attr}", value)
        end
      end
    end
  end
end

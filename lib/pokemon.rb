class Pokemon
    attr_accessor :name, :type, :db
    attr_reader :id

    def initialize(id:, name:, type:, db:)
        @id = id
        @name = name
        @type = type
        @db = db
    end

    def self.save(name, type, db)
        sql = <<-SQL
            INSERT INTO pokemon (name, type)
            VALUES (?, ?)
        SQL
        db.execute(sql, name, type)
    end

    def self.find(id, db)
        sql = <<-SQL
            SELECT * FROM pokemon
            WHERE id = ?
            LIMIT 1
        SQL
        row = db.execute(sql, id)[0]
        self.new(id: row[0], name: row[1], type: row[2], db: row[3])
    end
end

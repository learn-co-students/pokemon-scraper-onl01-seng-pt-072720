class Pokemon

    attr_accessor :id, :name, :type, :db

    def initialize(id:, name:, type:, db:)
        @id, @name, @type, @db = id, name, type, db
    end

    def self.save(name, type, db) 
        sql = <<-SQL
        INSERT INTO pokemon (name, type) VALUES (?, ?)
        SQL

        db.execute(sql, name, type)

        @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    end

    def self.new_from_db(row)
        id = row[0]
        name = row[1]
        type = row[2]
        self.new(id: id, name: name, type: type, db: @db)
      end

    def self.find(id, db)
        sql = <<-SQL
        SELECT * FROM pokemon 
        WHERE id = ?
        LIMIT 1
        SQL

        db.execute(sql, id).map do |row|
            self.new_from_db(row)
        end
    end
end

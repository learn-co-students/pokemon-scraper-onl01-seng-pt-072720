class Pokemon
    attr_accessor :name, :type, :db
    attr_reader :id

    def initialize(name:, type:, db:, id: nil)
       @name = name
       @type = type
       @db = db
       @id = id
    end

    def self.save(name, type, db)
        db.execute("INSERT INTO pokemon (name, type) VALUES (?, ?)", name, type)
        @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    end

    def self.find(id, db)
        sql = <<-SQL
        SELECT *
        FROM pokemon
        WHERE id = ?
        SQL

        db.execute(sql, id).map do |r|
            self.new(name: r[1], type: r[2], id: r[0], db: db)
        end.first
    end
end

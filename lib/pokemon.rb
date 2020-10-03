class Pokemon
    # saving, adding, removing, or changing
    attr_accessor :id, :name, :type, :db 

    def initialize(name:, type:, db:, id: nil)
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
        @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    end 

    def self.find(id, db)
        sql = <<-SQL
            SELECT *
            FROM pokemon
            WHERE id = ?
            LIMIT 1
        SQL

        db.execute(sql, id).map do |row|
            id = row[0]
            name = row[1]
            type = row[2]
            Pokemon.new(id: id, name: name, type: type, db: db)
        end.first
    end 

    # def self.find(id, db)
    #     pokemon_info = db.execute("SELECT * FROM pokemon WHERE id=?", id).flatten
    #     Pokemon.new(id: pokemon_info[0], name: pokemon_info[1], type: pokemon_info[2], db: db)
    # end
end
class Pokemon
    attr_accessor :id, :name, :type, :db

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
        @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    end

    def self.find(num, db)
        sql = <<-SQL
            SELECT * FROM pokemon WHERE id = ?
        SQL
        new_pokemon_info = db.execute(sql, num)[0] # => the db.execute(sql, num) returns [[1, "Pikachu," "electric"]], so [0] will grab just the inner array
        new_pokemon_hash = { id: new_pokemon_info[0], name: new_pokemon_info[1], type: new_pokemon_info[2], db: db } # => Create a hash for Pokemon.new to accept
        Pokemon.new(new_pokemon_hash)
    end

end

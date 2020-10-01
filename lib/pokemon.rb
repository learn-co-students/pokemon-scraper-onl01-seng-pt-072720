class Pokemon
    attr_accessor :name, :type, :id, :db

    def initialize(id:, name:, type:, db:)
        @name = name
        @type = type
        @db = db
        @id = id 
    end

    def self.save(name, type, db)
        sql = <<-SQL
            INSERT INTO pokemon (name, type) VALUES (?, ?);
        SQL
    
        db.execute(sql, name, type)        
    end

    def self.find(id, db)
        sql = <<-SQL
            select *
            FROM pokemon
            WHERE id = ?
        SQL

        pokemon = db.execute(sql, id).flatten
        name = pokemon[1]
        type = pokemon[2]    
        new_pokemon = Pokemon.new(id: id, name: name, type: type,  db: db)
    end

end

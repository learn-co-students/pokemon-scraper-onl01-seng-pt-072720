class Pokemon

    attr_accessor :name, :type, :db, :id

    def initialize(id:, name:, type:, db:)
        @name = name  
        @type = type 
        @id = id
        @db = db
    end

    def self.save(name, type, db)
        sql = <<-SQL
        INSERT INTO pokemon(name, type)
        VALUES(?,?)
        SQL
        db.execute(sql, name, type)
        @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    end


    def self.find(id,db)
        sql = <<-SQL
        SELECT *
        FROM pokemon 
        WHERE id = ?
        SQL
        pokemon = db.execute(sql, id).flatten
        new_pokemon = self.new(id: pokemon[0], name: pokemon[1], type: pokemon[2], db: db)
        new_pokemon 
    end


end

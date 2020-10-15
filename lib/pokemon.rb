class Pokemon

    attr_accessor :name, :type, :db
    attr_reader :id

    def initialize(name:, type:, db:, id:)
        @name = name
        @type = type
        @db = db
        @id = id
    end

def self.save(name,type,db)

    sql = <<-SQL
      INSERT INTO pokemon (name,type) VALUES (?, ?);
    SQL

    db.execute(sql,name,type) 
    end


    def self.find(id, db)
        sql = <<-SQL
          SELECT * FROM pokemon WHERE id = (?);
        SQL
        pokemon = db.execute(sql, id)
        Pokemon.new(id: id, name: pokemon[0][1], type: pokemon[0][2], db: db)
    end
end

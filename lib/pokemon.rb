class Pokemon
    attr_accessor :id, :name, :db, :type
    
    def initialize(id:,name:,type:,db:)
        @id = id
        @name = name
        @type = type
        @db = db  
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
        pokemon = db.execute(sql, id)    #can also use .map to go through the array and save name, id,type
        Pokemon.new(id: id, name: pokemon[0][1], type: pokemon[0][2], db: db) # use [][] because the data is in an array of arrays
    end
end

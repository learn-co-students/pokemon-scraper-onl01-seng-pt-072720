class Pokemon

    attr_accessor :id, :name, :type, :db

    def initialize(id:nil, name:, type:, db:)
        @id = id
        @name = name 
        @type = type 
        @db = db
    end 

    def self.save(name, type, db)
        sql = <<-SQL
        INSERT INTO pokemon (name, type) 
        VALUES (?, ?);
        SQL

        db.execute(sql, name, type)
        @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    end 

    def self.find(id, db)
        sql = <<-SQL
        SELECT * FROM pokemon WHERE id = (?);
        SQL

        db.execute(sql, id).map do |pokemon|
            id = pokemon[0]
            name = pokemon[1]
            type = pokemon[2]
        Pokemon.new(id: id, name: name, type: type, db: db)
        end.first
    end 

    # def alter_hp(new_hp)
    #     sql = <<-SQL
    #     UPDATE pokemon SET hp = ? WHERE id = ?;
    #     SQL
    #     db.execute(sql, [new_hp, id])
    # end 
    
end

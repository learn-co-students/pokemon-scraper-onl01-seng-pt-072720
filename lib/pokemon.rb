class Pokemon
  
  attr_accessor :id, :name, :type, :db
  
  def initialize(args)
    @id = args[0]
    @name = args[1]
    @type = args[2]
    @db = args[3]
  end
  
  
    def self.save(name, type, db)
    sql = <<-SQL
      INSERT INTO pokemon (name, type) VALUES (?, ?);
    SQL
    
    db.execute(sql, [name, type])
    
  end

  def self.find(id, db)
    sql = <<-SQL
      SELECT * FROM pokemon WHERE id = (?);
    SQL
    pokemon = db.execute(sql, [id]).flatten
    Pokemon.new([id, pokemon[1], pokemon[2], db])
  end

end

class Pokemon
  attr_accessor :id, :name, :type, :db 
  
  def initialize(id:, name:, type:, db:)
    @id = id
    @name = name
    @type = type
    @db = db
  end
  
  def self.save(name, type, db)
    db.execute("INSERT INTO pokemon (name, type) VALUES (?,?);", name, type)
  end
  
  def self.find(id, db)
    # find by id
    # return new object
    my_pokemon = db.execute("SELECT * FROM pokemon WHERE id = ?;", id).flatten
    self.new(id: my_pokemon[0], name: my_pokemon[1], type: my_pokemon[2], db: db)
  end
  
end

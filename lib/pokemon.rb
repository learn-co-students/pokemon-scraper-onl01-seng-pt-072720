class Pokemon

  attr_accessor :name, :type, :db, :id


  def initialize (id:, name:, type:,  db:)
     @id = id
     @name = name
     @type = type
     @db = db
   end

  def self.save(name, type, the_db)
  the_db.execute("INSERT INTO pokemon (name, type) VALUES (?, ?)", name, type)
  end

  def self.find(id, the_db)
  pokemon = the_db.execute("SELECT * FROM pokemon WHERE id = ?", id).flatten
  name = pokemon[1]
  type = pokemon[2]
  our_poke = Pokemon.new(id: id, name: name, type: type, db: the_db)
  end

end

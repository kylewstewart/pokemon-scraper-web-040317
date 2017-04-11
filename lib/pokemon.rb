require 'pry'

class Pokemon

  attr_accessor :id, :name, :type, :db, :hp

  def initialize(name:, type:, db:, id:, hp: nil)
    # binding.pry
    @id = id
    @name = name
    @type = type
    @db = db
    @hp = hp
  end

  def self.save(name, type, db)
    save = <<-save
    INSERT INTO pokemon (name, type)
    VALUES ('#{name}', '#{type}');
    save
    db.execute(save)
  end

  def self.find(id, db)
    find = "SELECT * FROM pokemon WHERE id = #{id};"
    result = db.execute(find).flatten
    self.new(name:result[1], type:result[2], db:db, id:id, hp:result[3])
  end

  def alter_hp(hp, db)
    db.execute("UPDATE pokemon SET hp=#{hp} WHERE name = '#{self.name}';")
    self.hp = hp
  end
end

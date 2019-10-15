require 'pry'
# Payer managing class
class Player
  attr_accessor :name, :hp
  @@ennemies = []

  # Méthode d'initialisation qui définit les valurs de noms et d'hp d'un nouveau joueur, et le range ensuite dans un array
  def initialize(name)
    @name = name
    @hp = 10
    @@ennemies << self
  end

  # Méthode de classe permettant d'afficher tous les objets "joueurs" présents
  def self.ennemies
    @@ennemies
  end

    # Méthode affichant l'état des joureurs, s'applique à un objet joueur et renvoie noms, hp, et weapon_level
  def show_state
    print "#{name} has #{hp} hp left"
  end

  def show_state_p
    print "#{name} has #{hp} hp left and a lvl #{@weapon_level} weapon"
  end

    # Méthode appliquant les dégats d'une attaque au joueur qui les reçoit
  def gets_damage(dmg)
    # hp du joueur subissant l'attaque - dégats de l'attaque
    @hp = @hp - dmg
    if @hp <= 0
      puts "Player #{name} has been killed !"
    end
  end

  def attacks(defender)
    # On récupère le résultat du jet de dé pour le montant des dégats de l'attaque
    damage = comp_dmg
    puts "#{name} attacks #{defender.name} for #{damage} damage !"
    defender.gets_damage(damage)
  end

  def comp_dmg
    return rand(1..6)
  end
end

# Human player managing class
class HumanPlayer < Player
  attr_accessor :weapon_level
  # On défini les stats du joueur
  def initialize(name)
    @name = name
    @hp = 100
    @weapon_level = 1
  end

  def self.human_player
    @@human_player
  end

  def comp_dmg
    rand(1..6) * @weapon_level
  end

  def search_weapon
    test = rand(1..6)
    puts " ************************"
    puts "|You found a lvl #{test} weapon|"
    puts " ************************"
    if @weapon_level < test
      puts
      puts "This weapon's better than mine, i'll take it !"
      @weapon_level = test
    else
      puts
      puts "Well that's some shitty weapon ..."
    end
  end

  def search_health_pack
    dice = rand(1..6)
    if dice == 1
      puts "Found nothing ..."
    elsif dice.between?(2, 5)
      if @hp <= 50
        @hp += 50
      else
        @hp = 100
      end
      puts "You found a +50hp pack !"
    else
      if @hp <= 20
        @hp += 80
      else
        @hp = 100
      end
      puts "You found a +80hp pack !"
    end
  end
end

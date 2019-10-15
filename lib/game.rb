require_relative 'player'
class Game
  attr_accessor :human_player, :enemies_in_sight, :players_left
  
  def initialize(name)
    @players_left = 10
    @enemies_in_sight = []
    @human_player = HumanPlayer.new(name)
    4.times do |i|
      # On utilise l'index pour nommer les différents joueurs
      @enemies_in_sight << Player.new("player#{i + 1}")
    end
  end

  def kill_player(en)
    # On parcoure l'array pour cibler le bot à éliminer
    @enemies_in_sight.each do |player|
      if player.name == en
        # On stocke le bot à éliminer dans une variable, pour pouvoir le passer en argument de .delete
        delete = player
      end
      @enemies_in_sight.delete(delete)
    end
  end

  def is_still_ongoing?
    return true if @human_player.hp > 0 && (@players_left >= 0)
  end

  def new_players_in_sight
    if @enemies_in_sight.size == @players_left
      puts "Every foes are in sight"
    end

    if @enemies_in_sight.size < @players_left
      dice = rand(0..6)
      if dice == 1
        puts "No more foes are incoming"
      elsif dice.between?(2, 4)
        puts "One enemy incoming !"
        n = rand(4..10)
        @enemies_in_sight << Player.new("player#{n}")
      else
        puts "Two enemies incoming !"
        2.times do |i|
          @enemies_in_sight << Player.new("player#{rand(4..10)}")
        end
      end
    end
  end

  def show_players
    puts @human_player.show_state_p
    puts "#{@enemies_in_sight.size} enemies_in_sight left"
  end

  def menu
    sleep(0.5)
    puts
    puts "Choose what to do next :"
    puts
    puts "w - look for better weapon"
    puts "h - look for a health pack"
    puts
    puts "Or"
    puts
    puts "Attack foe in sight"
    puts
    # On parcoure l'array enemies_in_sight, en utilisant chaque objet et son index
    @enemies_in_sight.each_with_index do |en, i|
      # On affiche les bots en fonction de leur place dans l'array
      # On affiche leurs noms et points de vie en appelant les variables d'instance correspondantes
      puts "#{i+1} - #{en.name} who's hp are #{en.hp}"
    end
    print "> "
  end

  def menu_choice(choice)
    # Tout ce que le joueur saisi autre que "w" ou "h" devient un entier
    unless choice == "w" || choice == "h" 
      choice = choice.to_i
    end
    if choice == "w"
      sleep(0.5)
      @human_player.search_weapon
    elsif choice == "h"
      sleep(0.5)
      @human_player.search_health_pack
      # si le joueur saisi un entier entre 1 et la taille max de l'array ennemi,
      # on parcoure l'array ennemies avec ses objets et index,
      # et dès que l'entier saisi par le joueur correspond à un bot, on lance une attaque sur ce bot
    elsif choice.between?(1, @enemies_in_sight.size)
      sleep(0.5)
      @enemies_in_sight.each_with_index do |en, i|
        if choice == i+1
          @human_player.attacks(en)
          # Si le bot ciblé est tué par l'attaque, on le supprime d'enemies_in_sight via la méthode kill_player
            if en.hp <= 0
              kill_player(en.name)
              @players_left -= 1
            end
        end
      end
    else
      puts
      puts "! Wrong command, try again !"
    end
  end

  def enemies_attack
    sleep(0.5)
    puts
    puts "You're attacked by your foes !"
    puts
    @enemies_in_sight.each do |en|
      sleep(0.3)
      en.attacks(@human_player)
      if @human_player.hp <= 0
        break
      end
    end
    puts
  end

  def end
    puts "Game over !"
    if @human_player.hp > 0
      puts "WELL DONE, YOU FUCKING WON !"
    else
      puts "HAHAHAH YOU LOST !"
    end
  end
end

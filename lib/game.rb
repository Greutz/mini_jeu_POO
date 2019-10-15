require_relative 'player'
class Game
  attr_accessor :human_player, :enemies
  
  def initialize(name)
    @enemies = []
    @human_player = HumanPlayer.new(name)
    4.times do |i|
      @enemies << Player.new("player#{i + 1}")
    end
  end

  def kill_player(en)
    @enemies.each do |player|
      if player.name == en
        delete = player
      end
      @enemies.delete(delete)
    end
  end

  def is_still_ongoing?
    return true if @human_player.hp > 0 && (@enemies.empty? == false)
  end

  def show_players
    puts @human_player.show_state_p
    puts "#{@enemies.size} enemies left"
  end

  def menu
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
    @enemies.each_with_index do |en, i|
      puts "#{i+1} - #{en.name} who's hp are #{en.hp}"
    end
    print "> "
  end

  def menu_choice(choice)
    unless choice == "w" || choice == "h" 
      choice = choice.to_i
    end
    if choice == "w"
      @human_player.search_weapon
    elsif choice == "h"
      @human_player.search_health_pack
    elsif choice.between?(1, @enemies.size)
      @enemies.each_with_index do |en, i|
        if choice == i+1
          @human_player.attacks(en)
            if en.hp <= 0
              kill_player(en.name)
            end
        end
      end
    else
      puts
      puts "! Wrong command, try again !"
    end
  end

  def enemies_attack 
    puts
    puts "You're attacked by your foes !"
    puts
    @enemies.each do |en|
        en.attacks(@human_player)
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

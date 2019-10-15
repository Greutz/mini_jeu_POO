require_relative 'player'
class Game < HumanPlayer
  attr_accessor :human_player, :ennemies
  def initialize(name)
    @human_player = HumanPlayer.new(name)
    en1 = Player.new("foe1")
    en2 = Player.new("foe2")
    en3 = Player.new("foe3")
    en4 = Player.new("foe4")
  end

  def kill_player
    @@ennemies.each do |en|
      if en.hp <= 0
        @@ennemies.delete(en)
      end
    end
  end

  def self.is_still_ongoing?
    return true if @human_player.hp > 0 && (@@ennemies.empty? == false)
  end
end

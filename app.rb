require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'


player1 = Player.new("Josiane")
player2 = Player.new("José")
while player1.hp > 0 && player2.hp > 0
  puts
  puts "Player hps :"
  puts
  puts "#{player1.show_state}"
  puts "#{player2.show_state}"
  puts
  puts "Starting attack phase !"
  puts
  player1.attacks(player2)
  if player2.hp <= 0
    puts "#{player1.name} WINS !"
    break
  end
  player2.attacks(player1)
  if player1.hp <= 0
    puts "#{player2.name} WINS !"
  end
end

binding.pry

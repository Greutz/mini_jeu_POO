require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

puts " -------------------------------"
puts "|Welcome to 'OOPs for loots' !  |"
puts "|Be the last one that survives !|"
puts " -------------------------------"

puts "What's your nickname ?"
print '> '
nick = gets.chomp
my_game = Game.new(nick)
player = my_game.human_player
while my_game.is_still_ongoing?
  my_game.show_players
  my_game.menu
  choice = gets.chomp
  my_game.menu_choice(choice)
  my_game.enemies_attack
end
my_game.end

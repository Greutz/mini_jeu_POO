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
player = HumanPlayer.new(nick)
player1 = Player.new("José")
player2 = Player.new("Josiane")

while player.hp > 0 && (player1.hp > 0 || player2.hp > 0)
  puts
  puts player.show_state_p
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
  puts "0 - Josiane, who's hp is at #{player2.hp}"
  puts "1 - José who's hp is at #{player1.hp}"
  print "> "
  choice = gets.chomp
  puts
  if choice == "w"
    player.search_weapon
  elsif choice == "h"
    player.search_health_pack
  elsif choice == "0"
    player.attacks(player2)
  elsif choice == "1"
    player.attacks(player1)
  else
    puts
    puts "! Wrong command, try again !"
  end
  puts
  Player.enemies.each_with_index do |en, i|
    if en.hp > 0 || player.hp <= 0
      puts "Enemy #{i} is attacking you !"
      en.attacks(player)
    end
  end
end
puts "Game over !"
if player.hp > 0
  puts "WELL DONE, YOU FUCKING WON !"
else
  puts "HAHAHAH YOU LOST !"
end

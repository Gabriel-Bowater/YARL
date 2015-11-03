require_relative 'character'
require_relative 'world'
require_relative 'creatures'

def main
	character = create_character
	character.view_sheet
	overworld = Overworld.new
	overworld.populate
	character.start_position(overworld.map)
	overworld.view(character.position)
	p character.position
	play_round(character, overworld)
end

def play_round(character, world)
	puts "Pick a direction - (w) up, (s) down, (a) left, or (d) right. (c) for character menu, (h) for help."
	input = gets.chomp.downcase
	while !["w","a","s","d", "h", "c"].include?(input)
		puts "Pick a direction - (w) up, (s) down, (a) left, or (d) right."
		input = gets.chomp.downcase	
	end

	if input == "h"
		show_help
	elsif input == "c"
		character_menu 
	else
		character.move(input, world.map)
		world.move_monsters
	end

	world.view(character.position)

	if character.alive
		play_round(character, world)
	else
		puts "#{character.name} has met their demise. They were level #{character.report_level} at the time of their death"
		puts "and had #{character.gold} gold on them. Thanks for playing!"
	end
end

def show_help
	puts "This is the help page. Pretty helpful, I know.... T = Tree, 0 = Player, R = Rock, # = Wall\n Press enter to continue..."
	gets
end

def character_menu
	puts "character menu....\n Press enter to continue..."
	gets
end


main
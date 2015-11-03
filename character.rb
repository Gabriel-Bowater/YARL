
class Character

	attr_reader :position, :alive, :name, :gold
	
	def initialize name, race, sex
		@sex = sex
		@name = name
		@race = race
		@inventory = []
		@xp = 0
		@gold = 0
		@spent_xp = 0
		@alive = true
		@position = []
		@standable_space = [" ", "T"]

		set_attributes

	end

	def set_attributes
		case @race
		when "man"
			@str = 3
			@int = 3
			@hp = 6
		when "troll"
			@str = 5
			@int = 0
			@hp = 7
		when "gnome"
			@str = 2
			@int = 6
			@hp = 4
		end
	end

	def view_sheet
		puts "-"* 20
		puts "#{@name}"
		puts "#{@sex}, #{@race}"
		puts "-"* 20
		puts "Level #{@str+@int+@hp-11}"
		puts "Strength: #{@str}"
		puts "Intelligence: #{@int}"
		puts "Hit points: #{@hp}"
		puts "-"* 20
		gets
	end

	def give_xp(ammount)
		@xp += ammount
		if @xp >= (@str+@int+@hp-11)*10-@spent_xp
			level_up
			@spent_xp += @xp
		end
	end

	def level_up
		puts "Congratulations. You are now Level #{@str+@int+@hp-10}"
		puts "Add a skill point to (1) Strength, (2) Intelligence or (3) Hit points."
		input = 0
		while input < 1 || input > 3 
			input = gets.to_i
		end
		if input == 1
			@str += 1
		elsif input == 2
			@int += 1
		else
			@hp += 1
		end
	end

	def report_level
		@str+@int+@hp-11
	end

	def give_gold(ammount)
		@gold += ammount
	end

	def spend_gold(ammount)
		@gold -= ammount
	end

	def start_position(map)
		x = map.length
		y = map[0].length
		good_position = false
		while !good_position
			x_coord = rand(x)
			y_coord = rand(y)
			if @standable_space.include?(map[x_coord][y_coord])
				@position = [x_coord,y_coord]
				good_position = true
			end 
		end
	end

	def move(direction, map)
		case direction
		when "w"
			new_position = [@position[0]-1, @position[1]]
		when "s"
			new_position = [@position[0]+1, @position[1]]
		when "a"
			new_position = [@position[0], @position[1]-1]		
		when "d"
			new_position = [@position[0], @position[1]+1]
		end

		if @standable_space.include?( map[new_position[0]][new_position[1]] )
			@position = new_position
		elsif map[new_position[0]][new_position[1]] == "R"
			puts "You walk into a rock. Thud"
		elsif map[new_position[0]][new_position[1]] == "#"
			puts "You walk into a wall. Good job"	
		elsif map[new_position[0]][new_position[1]] == "f"
			puts "You walked into the fire. You dead"
			@position = new_position
			@alive = false			
		end

	end

end#End of Class



def create_character
	puts "Welcome. What is your name?"
	name = gets.chomp
	puts "Very well, #{name}. Are you (1) Female or (2) Male?"
	input = 0
	while input < 1 || input > 2
		input = gets.chomp.to_i
	end
	sex = "female"
	sex = "male" if input == 2
	puts "So, #{if sex == "female" then "Ms" else "Mr" end} #{name}. What race are you?"
	puts "Are you \n(1) Man - 3 str, 3 int, 6 hp \n(2) Troll - 5 str, 0 int, 7 hp \n(3) Gnome - 2 str, 6 int, 4 hp"
	input = 0 
	while input < 1 || input > 3 
		input = gets.to_i
	end
	race = "man"
	race = "troll" if input == 2
	race = "gnome" if input == 3

	character = Character.new(name, race, sex)
	return character
end
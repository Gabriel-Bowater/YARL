class Creature

	attr_reader :position, :symbol, :alive, :alert

	def initialize(map)
		@hp = 1
		@hostile = true
		@symbol = "C"
		@position = starting_position(map)
		@xp_value = 1
		@drop = ["1 gp"]
		@power = 1
		@standable_space = [" ", "T"]
		@alert = false
		@alive = true
	end

	def starting_position(map)
		good_position = false
		x_coord = 0
		y_coord = 0
		while true
			x_coord = rand(map.length)
			y_coord = rand(map[0].length)

			if map[x_coord][y_coord] == " "
				p "position found #{x_coord}, #{y_coord}"
				break
			end
		end
		[x_coord, y_coord]
	end

	def move_idle(map)
		move = ["w","s","a","d","i"].sample
		case move
		when "w"
			new_position = [@position[0]-1, @position[1]]
		when "s"
			new_position = [@position[0]+1, @position[1]]
		when "a"
			new_position = [@position[0], @position[1]-1]		
		when "d"
			new_position = [@position[0], @position[1]+1]
		when "i"
			new_position = @position
		end
		if @standable_space.include?( map[new_position[0]][new_position[1]] )
			@position = new_position
		end
	end
		
end

class Goblin < Creature

	def initialize(map)
		super
		@symbol = "G"
		@hp = 2
		@power = 2
		@xp_value = 2
	end

end

class Wolf < Creature

	def initialize(map)
		super
		@symbol = "W"
		@hp = 4
		@xp_value = 3
	end

end

class Snake < Creature
	def initialize(map)
		super
		@symbol = "S"
	end
end

class Rat < Creature
	def initialize(map)
		super
		@symbol = "r"
	end
end

def generate_monsters(num, map)
	return_arr = []
	num.times do
		pick = rand(3)

		case pick
		when 0
			return_arr << Goblin.new(map)
		when 1
			return_arr << Wolf.new(map)
		when 2
			return_arr << Snake.new(map)
		when 3
			return_arr << Rat.new(map)
		end


	end

	return_arr.each do |mon|
		puts mon.symbol
		puts mon.position
	end
	gets

	return_arr
end
require_relative 'creatures'
class Overworld
	attr_accessor :map

	def initialize
		@map = generate( 32, 50 )
		@monsters = []
	end

	def generate( x, y )
		@building_map = Array.new
		x.times do |i| 
			@building_map << []
			y.times do |j|
				if i == 0 || j == 0 || i == x-1 || j == y-1
					@building_map[i] << "#"
				else
					@building_map[i] << " "
				end
			end
		end
		i = 0
		bases = (x*y)/25

		while i < bases

			rand_x = rand(x)
			rand_y = rand(y)
			if @building_map[rand_x][rand_y] == " "
				@building_map[rand_x][rand_y] = "#"
				branch(rand_x, rand_y)
		 		i += 1
			end
		end

		@building_map
	end

	def branch(x,y)
		x_mutator = x
		y_mutator = y
		horizontal = [:left, :right].sample
		vertical = [:up, :down]
		rand(5..15).times do
			vert_horiz = [:vert, :horiz].sample
			if vert_horiz == :vert
				if vertical == :down
					x_mutator +=1 
				else
					x_mutator -=1
				end
			else
				if horizontal == :right
					y_mutator +=1
				else
					y_mutator -=1
				end
			end

			if @building_map[x_mutator][y_mutator] == " "
				@building_map[x_mutator][y_mutator] = "#"
			else
				break
			end
		end
	end

	def view(character_position)
		system "clear"
		monster_positions = []
		@monsters.each {|mon| monster_positions << mon.position}
		@map.length.times do |array|
			row = []
			@map[array].length.times do |symbol|
				if [array,symbol] == character_position
					row << "0"

				elsif monster_positions.include?([array,symbol])

					@monsters.each do |monster|
						if monster.position == [array,symbol]
							row << monster.symbol
							break
						end
					end				

				else
					row << @map[array][symbol]
				end
			end
			puts "       "  +row.join("")
		end
	end

	def populate
		@map.each do |line|
			line.map! do |space|
				if space == " "
					if rand(50) == 10
						space = "T"
					elsif rand(50) == 10
						space = "R"
					elsif rand(100) == 3
						space = "f"
							
					else
						space = space
					end
				else
					space = space
				end
			end
		end

		@monsters = generate_monsters(10, @map)

	end

	def move_monsters
		@monsters.each do |mon|
			if mon.alive
				if mon.alert
				else
					mon.move_idle(@map)
				end
			end
		end
	end

end #End of class

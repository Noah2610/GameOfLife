
class Field
	attr_reader :index, :pos, :state
	def initialize args
		@index = [args[:index][0], args[:index][1]]
		@pos = {
			x: args[:pos][:x],
			y: args[:pos][:y]
		}
		@size = args[:size]
		@grid = args[:grid]
		@state = args[:state]
		@next_state = @state
	end

	def collision? pos
		if ( (pos[:x] > @pos[:x] && pos[:x] < @pos[:x] + @size) &&
				(pos[:y] > @pos[:y] && pos[:y] < @pos[:y] + @size) )
			return self
		end
		return false
	end

	def toggle
		case @state
		when :alive
			@state = :dead
		when :dead
			@state = :alive
		else
			@state = :NONE
		end
		return @state
	end

	def get_neighbors
		neighbors = []
		
		[-1,0,1].each do |n1|
			[-1,0,1].each do |n2|
				i1 = index[0] + n1
				i2 = index[1] + n2
				puts "#{i1}, #{i2} 		#{@grid.grid.length}, #{@grid.grid[n1].length}"
				if (@grid.grid[i1].nil?)
					i1 = i1 - @grid.grid.length
				end
				if (@grid.grid[i1][i2].nil?)
					i2 = i2 - @grid.grid[i1].length
				end
				next  if (n1 == 0 && n2 == 0)
				neighbors << @grid.grid[i1][i2].state
			end
		end

		return neighbors
	end

	def step
		# Next generation - get info
		neighbors = get_neighbors
		case @state
		when :alive
			# DIES
			if (neighbors.count(:alive).in_ranges?(RULES[:die]))
				puts neighbors.count(:alive)
				@next_state = :dead
			else
				@next_state = @state
			end

		when :dead
			# LIVES
			if (neighbors.count(:alive).in_ranges?(RULES[:birth]))
				@next_state = :alive
			end

		else
			@next_state = @state
		end
	end

	def step!
		# Actually apply new generation
		@state = @next_state
	end

	def draw
		bg_color = Gosu::Color.argb(0xff_aaaaaa)
		case @state
		when :alive
			fg_color = Gosu::Color.argb(0xff_999999)
		when :dead
			fg_color = Gosu::Color.argb(0xff_000000)
		else
			fg_color = Gosu::Color.argb(0xff_ff0000)
		end
		# border
		Gosu.draw_rect @pos[:x], @pos[:y], @size, @size, bg_color
		# center
		Gosu.draw_rect @pos[:x], @pos[:y], @size - 1, @size - 1, fg_color
	end
end


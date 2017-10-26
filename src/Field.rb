
class Field
	attr_reader :index, :pos
	def initialize args
		@index = [args[:index][0], args[:index][1]]
		@pos = {
			x: args[:pos][:x],
			y: args[:pos][:y]
		}
		@size = args[:size]
		@state = args[:state]
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

	def draw
		color = Gosu::Color.argb(0xff_ff0000)
		case @state
		when :alive
			color = Gosu::Color.argb(0xff_999999)
		when :dead
			color = Gosu::Color.argb(0xff_000000)
		end
		# border
		Gosu.draw_rect @pos[:x], @pos[:y], @size, @size, Gosu::Color.argb(0xff_aaaaaa)
		# center
		Gosu.draw_rect @pos[:x] + 1, @pos[:y] + 1, @size - 1, @size - 1, color
	end
end


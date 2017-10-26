
class Button
	attr_reader :id
	def initialize args
		@buffer = args[:buffer]
		@x = 0 + args[:offset][:x]   # @buffer.screen.w + args[:offset][:x]
		@y = @buffer.screen.h + args[:offset][:y]
		@size = args[:size]
		@@font = Gosu::Font.new 40
		@@bg_color = Gosu::Color.argb(0xff_999999)
		@@fg_color = Gosu::Color.argb(0xff_554444)
	end

	def collision? args
		if ( (args[:x] > @x && args[:x] < @x + @size[:w] ) &&
			   (args[:y] > @y && args[:y] < @y + @size[:h]) )
			return self
		end
		return nil
	end

	def click args
	end

	def draw
	end
end

class StepButton < Button
	def draw
		bg_color = @@bg_color
		fg_color = @@fg_color
		Gosu.draw_rect @x, @y, @size[:w], @size[:h], bg_color
		@@font.draw_rel "Step", (@x + (@size[:w] / 2)).to_i, (@y + (@size[:h] / 2)).to_i, 0, 0.5,0.45, 1,1, fg_color
	end

	def click args
		# Next generation
=begin
		@buffer.screen.grid.grid.each &:step
		@buffer.screen.grid.grid.each &:step!
=end
	end
end


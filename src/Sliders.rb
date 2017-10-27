
class Slider
	def initialize args
		@buffer = args[:buffer]
		@x = 0 + args[:offset][:x]   # @buffer.screen.w + args[:offset][:x]
		@y = @buffer.screen.h + args[:offset][:y]
		@size = args[:size]
		@@font = Gosu::Font.new 40
		@@bg_color = Gosu::Color.argb(0xff_999999)
		@@fg_color = Gosu::Color.argb(0xff_554444)
		@handle = args[:handle]
		init  if self.class.instance_methods(false).include?(:init)
	end

	def collision? args
		if ( (args[:x] > @x && args[:x] < @x + @size[:w] ) &&
			   (args[:y] > @y && args[:y] < @y + @size[:h]) )
			return self
		end
		return nil
	end

	def get_handle_position
		(@x + (@size[:w].to_f / 100.0 * @handle[:value].to_f) - (@handle[:size][:w].to_f / 2.0))
	end

	def draw
	end

	def drag args
		@handle[:value] = (args[:x] - @x) / @size[:w] * 100
		$gen_speed = (60.0 - (@handle[:value] / 100.0 * 60.0)).to_i
		$gen_speed = 1  unless ($gen_speed > 0)
	end
end

class SpeedSlider < Slider
	def draw
		bg_color = @@bg_color
		fg_color = @@fg_color
		#Gosu.draw_rect @x, @y, @size[:w], @size[:h], bg_color
		#@@font.draw_rel "Step", (@x + (@size[:w] / 2)).to_i, (@y + (@size[:h] / 2)).to_i, 0, 0.5,0.45, 1,1, fg_color

		# Draw line / track
		Gosu.draw_rect @x, @y + (@size[:h] / 2), @size[:w], 2, bg_color
		# Draw draggable handle
		Gosu.draw_rect get_handle_position, @y, @handle[:size][:w], @handle[:size][:h], fg_color
	end
end


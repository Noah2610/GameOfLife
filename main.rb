
require 'gosu'
require 'awesome_print'

require './src/Screen.rb'
require './src/Grid.rb'
require './src/Field.rb'
require './src/Buffer.rb'
require './src/Buttons.rb'
require './src/Sliders.rb'

class Integer
	def in_ranges? ranges
		ranges.each do |range|
			if (range.member? self)
				return true
			end
		end
		return false
	end
end

RULES = {
	idle: [
		(2 .. 3)
	],
	die: [
		(-Float::INFINITY .. 1),
		(4 .. Float::INFINITY)
	],
	birth: [
		(3 .. 3)
	]
}

$playing = false
$gen_speed = 30

class Game < Gosu::Window
	def initialize
		@screen = Screen.new
		@buffer = @screen.buffer
		super @screen.w, @screen.h + @buffer.h
		self.caption = "Conway's Game Of Life"
		@update_time = 0
		@prev_time = 0.0
		@step_time = 0.0
	end

	def button_down id
		case id
		when Gosu::KB_Q
			close
		when Gosu::MsLeft
			@screen.click x: mouse_x, y: mouse_y
		end
	end

	def button_up id
		case id
		when Gosu::MsLeft
			@screen.grid.last_toggled = nil
		end
	end

	def needs_cursor?
		true
	end

	def update
		dt = ((Gosu.milliseconds.to_f / 60.0) - @prev_time)
		@prev_time = (Gosu.milliseconds.to_f / 60.0)
		@update_time += dt

		if (Gosu.button_down? 256)
			@screen.grid.click x: mouse_x, y: mouse_y
			@screen.buffer.drag x: mouse_x, y: mouse_y
		end

		if ($playing && @step_time >= $gen_speed)
			@buffer.screen.grid.grid.each { |col| col.each &:step }
			@buffer.screen.grid.grid.each { |col| col.each &:step! }
			@step_time = 0.0
		elsif ($playing && @step_time < $gen_speed)
			@step_time += dt * 3.8
		end
	end

	def draw
		# Draw screen
		@screen.draw
	end
end

game = Game.new
game.show


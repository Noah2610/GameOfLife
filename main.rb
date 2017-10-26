
require 'gosu'
require 'awesome_print'

require './src/Screen.rb'
require './src/Grid.rb'
require './src/Field.rb'
require './src/Buffer.rb'
require './src/Buttons.rb'

class Game < Gosu::Window
	def initialize
		@screen = Screen.new
		@buffer = @screen.buffer
		super @screen.w + @buffer.w, @screen.h + @buffer.h
		self.caption = "Conway's Game Of Life"
	end

	def button_down id
		case id
		when Gosu::KB_Q
			close
		when Gosu::MsLeft
			@screen.click x: mouse_x, y: mouse_y
		end
	end

	def needs_cursor?
		true
	end

	def update
	end

	def draw
		# Draw screen
		@screen.draw
	end
end

game = Game.new
game.show


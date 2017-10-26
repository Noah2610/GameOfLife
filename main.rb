
require 'gosu'
require 'awesome_print'

require './src/Screen.rb'
require './src/Grid.rb'
require './src/Field.rb'

class Game < Gosu::Window
	def initialize
		@screen = Screen.new
		super @screen.x, @screen.y
		self.caption = "Conway's Game Of Life"
	end

	def button_down id
		case id
		when Gosu::KB_Q
			close
		when Gosu::MsLeft
			@screen.grid.click mouse_x, mouse_y
		end
	end

	def needs_cursor?
		true
	end

	def update
	end

	def draw
		# Draw grid
		@screen.grid.draw
	end
end

game = Game.new
game.show


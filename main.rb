
require 'gosu'
require 'awesome_print'

require './src/Screen.rb'
require './src/Grid.rb'
require './src/Field.rb'
require './src/Buffer.rb'
require './src/Buttons.rb'

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

class Game < Gosu::Window
	def initialize
		@screen = Screen.new
		@buffer = @screen.buffer
		super @screen.w, @screen.h + @buffer.h
		self.caption = "Conway's Game Of Life"
		@@update_time = 0
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
		if ($playing && @@update_time % 30 == 0 )
			@buffer.screen.grid.grid.each { |col| col.each &:step }
			@buffer.screen.grid.grid.each { |col| col.each &:step! }
		end
		@@last_update = Time.now
		@@update_time += 1
		#TODO do this properly ^
	end

	def draw
		# Draw screen
		@screen.draw
	end
end

game = Game.new
game.show


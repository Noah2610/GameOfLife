
require 'gosu'
require 'awesome_print'

class Screen
	attr_reader :x,:y, :grid
	def initialize
		@x = 640
		@y = 480
		@grid_size = 32
		@grid = Grid.new w: @x, h: @y, grid_size: @grid_size
	end
end

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

	def draw
		color = Gosu::Color.argb(0xff_ff0000)
		case @state
		when :alive
			color = Gosu::Color.argb(0xff_000000)
		when :dead
			color = Gosu::Color.argb(0xff_ffffff)
		end
		Gosu.draw_rect @pos[:x], @pos[:y], @size, @size, Gosu::Color.argb(0xff_aaaaaa)                   # border
		Gosu.draw_rect @pos[:x] + 1, @pos[:y] + 1, @size - 1, @size - 1, (Gosu::Color.argb(0xff_0000000))  # center
	end
end

class Grid
	attr_reader :grid
	def initialize args
		@screen = {
			w: args[:w],
			h: args[:h],
		}
		@grid_size = args[:grid_size]
		@grid = mk_grid
	end

	def mk_grid
		grid = []
		max_x = (@screen[:w] / @grid_size).floor
		max_y = (@screen[:h] / @grid_size).floor
		max_x.times do |x|
			grid << []
			max_y.times do |y|
				grid[x] << Field.new(
					pos: {
						x:     (x * @grid_size),
						y:     (y * @grid_size),
					},
					index: [x,y],
					size: @grid_size,
					state: :dead
				)
			end
		end
		return grid
	end

	def draw
		@grid.each do |col|
			col.each do |field|
				field.draw
			end
		end
	end

	def click (mouse_x, mouse_y)
		field = grid_collision x: mouse_x, y: mouse_y
		puts field.index.to_s  if (field)
	end

	def grid_collision pos
		@grid.each do |col|
			col.each do |field|
				ret = field.collision?(pos)
				return ret  if ret
			end
		end
		return nil
	end

end

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


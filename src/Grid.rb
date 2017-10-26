
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
		field.toggle  if (field)
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


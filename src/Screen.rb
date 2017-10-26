
class Screen
	attr_reader :x,:y, :grid
	def initialize
		@x = 640
		@y = 480
		@grid_size = 32
		@grid = Grid.new w: @x, h: @y, grid_size: @grid_size
	end
end


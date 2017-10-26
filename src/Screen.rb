
class Screen
	attr_reader :w,:h, :buffer, :grid, :buttons
	def initialize
		@w = 640
		@h = 480
		@buffer = Buffer.new w: @w, h: 64, screen: self
		@grid_size = 32
		@grid = Grid.new w: @w, h: @h, grid_size: @grid_size
	end

	def click args
		#return true  if (@grid.click(args) || @buffer.click(args))
		return true  if (@buffer.click(args))
		return false
	end

	def draw
		# Draw grid
		@grid.draw
		# Draw buffer
		@buffer.draw
	end
end


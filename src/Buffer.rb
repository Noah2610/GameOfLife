
class Buffer
	attr_reader :w, :h, :side, :screen
	def initialize args
		@w      = args[:w]
		@h      = args[:h]
		@side   = args[:side]    if defined?(args[:side])
		@screen = args[:screen]  if defined?(args[:screen])


		@buttons = [
			StepButton.new(buffer: self, offset: { x: 16, y: 16 }, size: { w: 128, h: 32 } ),

			TogglePlayButton.new(buffer: self, offset: { x: 160, y: 16 }, size: { w: 128, h: 32 } )
		]
	end

	def click args
		@buttons.each do |btn|
			if (btn.collision?(args))
				btn.click args
			end
		end
	end

	def draw
		# Draw buttons
		@buttons.each &:draw
	end
end

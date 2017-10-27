
class Buffer
	attr_reader :w, :h, :side, :screen
	def initialize args
		@w      = args[:w]
		@h      = args[:h]
		@side   = args[:side]    if defined?(args[:side])
		@screen = args[:screen]  if defined?(args[:screen])

		@buttons = [
			#PlayButton.new(buffer: self, offset: { x: (@w - 304), y: 16 }, size: { w: 128, h: 32 } ),
			#PauseButton.new(buffer: self, offset: { x: (@w - 160), y: 16 }, size: { w: 128, h: 32 } ),
			StepButton.new(buffer: self, offset: { x: 16, y: 16 }, size: { w: 128, h: 32 } ),
			TogglePlayButton.new(buffer: self, offset: { x: 160, y: 16 }, size: { w: 128, h: 32 } )
		]

		@sliders = [
			SpeedSlider.new(
				buffer: self,
				offset: { x: 304, y: 16 },
				size: { w: 128, h: 32 },
				handle: { value: 0, size: { w: 16, h: 32 } }
			)
		]
	end

	def click args
		@buttons.each do |btn|
			if (btn.collision?(args))
				btn.click args
			end
		end
	end

	def drag args
		@sliders.each do |slider|
			if (slider.collision?(args))
				slider.drag args
			end
		end
	end

	def draw
		# Draw buttons and sliders
		@buttons.each &:draw
		@sliders.each &:draw
	end
end

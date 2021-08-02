module UserInterface
  class Window < View
    def initialize(frame)
      super
      @graphics_context = CoreGraphics::Context.new(frame.position, frame.size)
      @hidden = true
      @background_color = UserInterface::Color.white
    end

    attr_reader :graphics_context
    attr_accessor :view_controller

    # TODO: spec
    def view_controller=(value)
      if subviews.count > 1
        @view_controller.view_will_disappear
        subviews.each { |subview| subview.remove_from_superview }
        @view_controller.view_did_disappear
      end
      @view_controller = value
      @view_controller.view_will_appear
      add_subview(@view_controller.view)

      @view_controller.view.frame = CoreGraphics::Rectangle.new(
        CoreGraphics::Point.new(0, 0),
        frame.size
      )

      @view_controller.view_did_appear
    end

    def window
      self
    end

    def make_key_and_visible
      make_key
      self.hidden = false
    end

    def make_key
      Application.shared.key_window = self
    end

    def set_needs_display
      return if layer.needs_display?

      layer.set_needs_display

      window_display = WindowDisplay.new(self)
      dirty_timer = Timer.new(object: window_display, selector: :draw)
      RunLoop.main.add_timer(dirty_timer)
    end
  end
end

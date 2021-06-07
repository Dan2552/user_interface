module UserInterface
  class ViewController
    def view
      if !@view
        load_view
        view_did_load
      end

      @view
    end

    def load_view
      position = CoreGraphics::Point.new(100, 100)
      size = CoreGraphics::Size.new(150, 150)
      frame = CoreGraphics::Rectangle.new(position, size)
      @view = UserInterface::View.new(frame)
      @view._view_delegate = self
    end

    def view_will_disappear
    end

    def view_did_disappear
    end

    def view_will_appear
    end

    def view_did_appear
    end

    def view_did_load
    end
  end
end

module UserInterface
  class View
    def initialize(frame)
      @frame = frame
      @bounds = frame
      @z_index = 0
      @background_color = UserInterface::Color.white
      @subviews = [] #CoreStructures::BinarySortInsertArray.new(:z_index)
      @hidden = false
    end

    attr_reader :frame
    attr_reader :bounds
    attr_reader :background_color
    attr_reader :z_index
    attr_reader :layer
    attr_reader :superview
    attr_accessor :hidden
    attr_accessor :_view_delegate

    def background_color=(value)
      @background_color = value
      set_needs_display
    end

    def frame=(value)
      return if @frame == value

      if value.size != bounds.size
        @bounds = CoreGraphics::Rectangle.new(bounds.position, value.size)
      end

      @frame = value
      @layer = nil
      set_needs_display
    end

    def bounds=(value)
      return if @bounds == value

      if value.size != frame.size
        @frame = CoreGraphics::Rectangle.new(frame.position, value.size)
        @layer = nil
        set_needs_display
      end

      @bounds = value
    end

    def add_subview(child_view)
      if child_view.superview != nil || @subviews.include?(child_view)
        "Attempting to add subview to another view, when it already belongs to another"
      end

      @subviews << child_view

      child_view.send(:superview=, self)
    end

    def remove_from_superview
      if @superview.nil?
        raise "Attempting to remove superview from a view without one"
      end

      parent_subviews = @superview.instance_variable_get(:@subviews)
      parent_subviews.delete(self)
      @layer = nil
      @superview = nil
    end

    def layer
      @layer = nil if window != @layer_window
      @layer ||= begin
        return nil unless window
        @layer_window = window
        layer = CoreGraphics::Layer.new(
          window.graphics_context,
          CoreGraphics::Size.new(
            frame.size.width * window.graphics_context.render_scale,
            frame.size.height * window.graphics_context.render_scale
          )
        )
        layer.delegate = self
        layer
      end
    end

    def subviews
      @read_only_subviews ||= CoreStructures::ProxyWithDeniedMethods.new(
        @subviews,
        [
          :[]=,
          :append,
          :clear,
          :collect!,
          :compact!,
          :delete,
          :delete_at,
          :delete_if,
          :drop,
          :drop_while,
          :filter!,
          :flatten!,
          :insert,
          :keep_if,
          :map!,
          :pop,
          :prepend,
          :push,
          :reject!,
          :replace,
          :reverse!,
          :reverse_each,
          :rotate!,
          :select!,
          :shift,
          :shuffle!,
          :slice!,
          :sort!,
          :sort_by!,
          :uniq!,
          :unshift,
        ]
      )
    end

    def window
      return nil unless superview
      superview.window
    end

    def set_needs_display
      return if layer.nil?
      return if layer.needs_display?

      layer.set_needs_display
      superview.set_needs_display
    end

    def draw
      @layer.clear_with_color(
        background_color.red,
        background_color.green,
        background_color.blue,
        background_color.alpha,
      )
    end

    # (CoreGraphics::Layer delegate)
    #
    def layer_will_draw(layer)
      return unless self.layer == layer
    end

    # (CoreGraphics::Layer delegate)
    #
    def draw_layer(layer)
      return unless self.layer == layer
      draw
    end

    # (CoreGraphics::Layer delegate)
    #
    # Drawing layer has resized, but hopefully it's a case of shuffling things
    # around rather than redrawing all children from scratch.
    #
    def layout_sublayers(layer)
      return unless self.layer == layer
    end

    private

    def superview=(value)
      @superview = value
      subviews.each { |subview| subview.send(:superview=, self) }
      set_needs_display
    end
  end
end

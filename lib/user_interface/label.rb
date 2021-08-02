module UserInterface
  class Label < View
    def initialize(frame)
      super
      @background_color = UserInterface::Color.clear
      @text_color = Color.black
      @text_alignment = :left
      @number_of_lines = 1
      @font = CoreGraphics::Font.new("Arial", 17)
    end

    attr_reader :text
    attr_reader :font
    attr_reader :text_color
    attr_reader :text_alignment
    attr_reader :number_of_lines

    def text=(value)
      @text = value
      refresh_text_layer
      set_needs_display
    end

    def font=(value)
      @font = value
      refresh_text_layer
      set_needs_display
    end

    def text_color=(value)
      @text_color = value
      set_needs_display
    end

    def text_alignment=(value)
      @text_alignment = value
      set_needs_display
    end

    def number_of_lines=(value)
      @number_of_lines = value
      set_needs_display
    end

    def draw
      super

      raise "No font for #{self}" unless @font

      @text_layer ||= @font.layer_for(window.graphics_context, text)

      layer.draw_child_layer(
        @text_layer,
        0,
        0,
        @text_layer.size.width,
        @text_layer.size.height
      )
    end

    private

    def refresh_text_layer
      @text_layer = nil
    end
  end
end

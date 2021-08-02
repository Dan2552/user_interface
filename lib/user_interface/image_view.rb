module UserInterface
  class ImageView < View
    def initialize(image)
      @image = image
      position = CoreGraphics::Point.new(0, 0)
      # TODO: if image is @2x, don't scale
      frame = CoreGraphics::Rectangle.new(
        position,
        CoreGraphics::Size.new(
          @image.size.width,
          @image.size.height
        )
      )
      super(frame)
    end

    attr_reader :image

    def draw
      super

      layer.draw_child_layer(
        @image.layer_for(window.graphics_context),
        0,
        0,
        frame.size.width * window.graphics_context.render_scale,
        frame.size.height * window.graphics_context.render_scale
      )
    end
  end
end

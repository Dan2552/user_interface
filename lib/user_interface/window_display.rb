module UserInterface
  class WindowDisplay
    def initialize(window)
      @window = window
    end

    def draw
      # Draw the texture for each layer that needs redisplay.
      draw_view(@window)

      # Draw window texture to renderer
      @window.layer.c__draw

      # Draw to screen
      @window.graphics_context.c__orbit
    end

    private

    def draw_view(view, debug: "")
      return unless view.layer.needs_display?

      # draw the base for this view
      view.layer.draw

      # puts "#{debug}Drawing #{view} with #{view.subviews.class} #{view.subviews.count} children"
      view.subviews.each do |subview|
        # redraw the subview (if it needs it!)
        draw_view(subview, debug: "  ")

        x_offset = 0
        y_offset = 0

        if view.respond_to?(:content_offset)
          x_offset = view.content_offset.x
          y_offset = view.content_offset.y
        end

        # add the subview texture onto this view
        view.layer.draw_child_layer(
          subview.layer,
          (subview.frame.position.x + x_offset) * @window.graphics_context.render_scale,
          (subview.frame.position.y + y_offset) * @window.graphics_context.render_scale,
          subview.frame.size.width * @window.graphics_context.render_scale,
          subview.frame.size.height * @window.graphics_context.render_scale
        )
      end
    end
  end
end

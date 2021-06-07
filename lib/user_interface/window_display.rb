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
      # puts "#{debug}handling #{view}. Needs display? #{view.layer.needs_display?}"
      return unless view.layer.needs_display?

      # draw the base for this view
      view.layer.draw

      # puts "#{debug}Drawing #{view} with #{view.subviews.class} #{view.subviews.count} children"
      view.subviews.each do |subview|
        # redraw the subview (if it needs it!)
        draw_view(subview, debug: "  ")

        # add the subview texture onto this view
        view.layer.draw_child_layer(
          subview.layer,
          subview.frame.position.x,
          subview.frame.position.y,
          subview.frame.size.width,
          subview.frame.size.height
        )
      end
    end
  end
end

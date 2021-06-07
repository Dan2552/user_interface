module UserInterface
  class Label < View
    def initialize(frame)
      super
      @text_color = Color.black
      @text_alignment = :left
      @number_of_lines = 1
    end

    attr_accessor :text
    attr_accessor :font
    attr_accessor :text_color
    attr_accessor :text_alignment
    attr_accessor :number_of_lines
  end
end

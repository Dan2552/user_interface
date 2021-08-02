module UserInterface
  class Color
    def self.white
      new(255, 255, 255, 255)
    end

    def self.black
      new(0, 0, 0, 255)
    end

    def self.red
      new(255, 0, 0, 255)
    end

    def self.green
      new(0, 255, 0, 255)
    end

    def self.blue
      new(0, 0, 255, 255)
    end

    def self.clear
      new(0, 0, 0, 0)
    end

    def initialize(red, green, blue, alpha)
      @red = red
      @green = green
      @blue = blue
      @alpha = alpha
    end

    attr_reader :red
    attr_reader :green
    attr_reader :blue
    attr_reader :alpha

    def ==(rhs)
      (
        red == rhs.red &&
        green == rhs.green &&
        blue == rhs.blue &&
        alpha == rhs.alpha
      )
    end

    def inspect
      to_s
    end

    def to_s
      "<Color #{red} #{green} #{blue} #{alpha}>"
    end
  end
end

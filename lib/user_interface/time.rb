module UserInterface
  class Time
    def self.delta
      @delta || 0
    end

    def self.delta=(value)
      @delta = value
    end
  end
end

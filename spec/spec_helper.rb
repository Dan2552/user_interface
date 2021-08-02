require "user_interface"

RSpec.configure do |config|
  config.color = true
  config.tty = true
  config.filter_run_when_matching :focus
end

# Stubs for third party dependencies
module CoreGraphics
  class Font
    def initialize(_, _)
    end
  end
  class Layer
    def initialize(_, _)
    end
    def delegate=(_)
    end
    def needs_display?
    end
    def set_needs_display
    end
  end
  class Context
    def initialize(_, _)
    end

    def render_scale
      2
    end
  end
  class Point
    def initialize(_, _)
    end
  end
  class Size
    def initialize(_, _)
    end
  end
  class Rectangle
    def initialize(_, _)
    end
    def size
    end
  end
end

# Stubs for third party dependencies
module CoreStructures
  class BinarySortInsertArray
    def initialize(_)
    end
  end

  def self.read_only(x)
    x
  end

  class ProxyWithDeniedMethods
    def initialize(object, _)
      @object = object
    end

    def respond_to?(*args)
      @object.respond_to?(*args)
    end

    def method_missing(meth, *args, &blk)
      @object.public_send(meth, *args, &blk)
    end
  end
end

class AppDelegate
end

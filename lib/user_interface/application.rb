module UserInterface
  class Application
    def self.shared
      @shared || raise("Application shared state is lost")
    end

    # This should only be called by ApplicationMain.
    #
    def self.create_shared
      @shared = new
    end

    def initialize
      @windows = []
      @delegate = AppDelegate.new
      @key_window
    end

    attr_reader :windows
    attr_reader :delegate
    attr_accessor :key_window
  end
end

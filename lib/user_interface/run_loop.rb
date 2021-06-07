module UserInterface
  class RunLoop
    def self.main
      @main ||= new
    end

    def initialize
      @timers = {}
      @timers[:default] = []
    end

    def add_timer(timer, mode: :default)
      raise("Unknown mode") unless @timers.keys.include?(mode)

      @timers[mode] << timer
    end

    def run
      loop do
        delta = UserInterface.refresh_delta
        Time.delta = delta
        run_timers(:default)

        if delta < 0.01
          sleep(0.01 - delta)
        end
      end
    end

    private

    def run_timers(mode)
      active_timers = []

      @timers[mode].each do |timer|
        next if timer.invalidated?

        active_timers << timer
        timer.fire if timer.interval_elapsed?
      end

      @timers[mode] = active_timers
    end
  end
end

module UserInterface
  class EventLoop
    def update
      Event.poll do |event|
        quit if event.type == :quit
      end
    end

    private

    def quit
      raise ExitError
    end
  end
end

module UserInterface
  class ApplicationMain
    def initialize
      Application.create_shared
      @application = Application.shared
      @app_delegate = @application.delegate
    end

    def launch
      delegate(:application_will_finish_launching)
      delegate(:application_did_finish_launching)

      # Startup the RunLoop with the event loop as the only process to run. Upon
      # needing it, the UI code will add timers to deal with rendering specific
      # parts. This means the RunLoop won't needlessly iterate the whole view
      # tree every loop in order to work out if something needs re-rendering.
      run_loop = RunLoop.main
      event_loop = Timer.new(
        repeats: true,
        object: EventLoop.new,
        selector: :update
      )
      run_loop.add_timer(event_loop)

      delegate(:application_did_become_active)

      run_loop.run
    rescue ExitError
    ensure
      delegate(:application_will_terminate)
    end

    private

    def delegate(selector)
      return unless @app_delegate && @app_delegate.respond_to?(selector)
      @app_delegate.send(selector, @application)
    end
  end
end

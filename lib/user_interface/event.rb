module UserInterface
  class Event
    TYPES = {
      (SDL_FIRSTEVENT = 0) => :firstevent,

      (SDL_QUIT = 0x100) => :quit,
      (SDL_APP_TERMINATING = 0x100 + 1) => :app_terminating,
      (SDL_APP_LOWMEMORY = 0x100 + 2) => :app_lowmemory,
      (SDL_APP_WILLENTERBACKGROUND = 0x100 + 3) => :app_willenterbackground,
      (SDL_APP_DIDENTERBACKGROUND = 0x100 + 4) => :app_didenterbackground,
      (SDL_APP_WILLENTERFOREGROUND = 0x100 + 5) => :app_willenterforeground,
      (SDL_APP_DIDENTERFOREGROUND = 0x100 + 6) => :app_didenterforeground,
      (SDL_LOCALECHANGED = 0x100 + 7) => :localechanged,

      (SDL_DISPLAYEVENT = 0x150) => :displayevent,

      (SDL_WINDOWEVENT = 0x200) => :windowevent,
      (SDL_SYSWMEVENT = 0x200 + 1) => :syswmevent,

      (SDL_KEYDOWN = 0x300) => :keydown,
      (SDL_KEYUP = 0x300 + 1) => :keyup,
      (SDL_TEXTEDITING = 0x300 + 2) => :textediting,
      (SDL_TEXTINPUT = 0x300 + 3) => :textinput,
      (SDL_KEYMAPCHANGED = 0x300 + 4) => :keymapchanged,

      (SDL_MOUSEMOTION = 0x400) => :mousemotion,
      (SDL_MOUSEBUTTONDOWN = 0x400 + 1) => :mousebuttondown,
      (SDL_MOUSEBUTTONUP = 0x400 + 2) => :mousebuttonup,
      (SDL_MOUSEWHEEL = 0x400 + 3) => :mousewheel,

      (SDL_JOYAXISMOTION = 0x600) => :joyaxismotion,
      (SDL_JOYBALLMOTION = 0x600 + 1) => :joyballmotion,
      (SDL_JOYHATMOTION = 0x600 + 2) => :joyhatmotion,
      (SDL_JOYBUTTONDOWN = 0x600 + 3) => :joybuttondown,
      (SDL_JOYBUTTONUP = 0x600 + 4) => :joybuttonup,
      (SDL_JOYDEVICEADDED = 0x600 + 5) => :joydeviceadded,
      (SDL_JOYDEVICEREMOVED = 0x600 + 6) => :joydeviceremoved,

      (SDL_CONTROLLERAXISMOTION = 0x650) => :controlleraxismotion,
      (SDL_CONTROLLERBUTTONDOWN = 0x650 + 1) => :controllerbuttondown,
      (SDL_CONTROLLERBUTTONUP = 0x650 + 2) => :controllerbuttonup,
      (SDL_CONTROLLERDEVICEADDED = 0x650 + 3) => :controllerdeviceadded,
      (SDL_CONTROLLERDEVICEREMOVED = 0x650 + 4) => :controllerdeviceremoved,
      (SDL_CONTROLLERDEVICEREMAPPED = 0x650 + 5) => :controllerdeviceremapped,
      (SDL_CONTROLLERTOUCHPADDOWN = 0x650 + 6) => :controllertouchpaddown,
      (SDL_CONTROLLERTOUCHPADMOTION = 0x650 + 7) => :controllertouchpadmotion,
      (SDL_CONTROLLERTOUCHPADUP = 0x650 + 8) => :controllertouchpadup,
      (SDL_CONTROLLERSENSORUPDATE = 0x650 + 9) => :controllersensorupdate,

      (SDL_FINGERDOWN = 0x700) => :fingerdown,
      (SDL_FINGERUP = 0x700 + 1) => :fingerup,
      (SDL_FINGERMOTION = 0x700 + 2) => :fingermotion,

      (SDL_DOLLARGESTURE = 0x800) => :dollargesture,
      (SDL_DOLLARRECORD = 0x800 + 1) => :dollarrecord,
      (SDL_MULTIGESTURE = 0x800 + 2) => :multigesture,

      (SDL_CLIPBOARDUPDATE = 0x900) => :clipboardupdate,

      (SDL_DROPFILE = 0x1000) => :dropfile,
      (SDL_DROPTEXT = 0x1000 + 1) => :droptext,
      (SDL_DROPBEGIN = 0x1000 + 2) => :dropbegin,
      (SDL_DROPCOMPLETE = 0x1000 + 3) => :dropcomplete,

      (SDL_AUDIODEVICEADDED = 0x1100) => :audiodeviceadded,
      (SDL_AUDIODEVICEREMOVED = 0x1100 + 1) => :audiodeviceremoved,

      (SDL_SENSORUPDATE = 0x1200) => :sensorupdate,

      (SDL_RENDER_TARGETS_RESET = 0x2000) => :render_targets_reset,
      (SDL_RENDER_DEVICE_RESET = 0x2000 + 1) => :render_device_reset,

      (SDL_USEREVENT = 0x8000) => :userevent,

      (SDL_LASTEVENT = 0xFFFF) => :lastevent
    }

    def type
      TYPES[@type]
    end

    def inspect
      "#<UserInterface::Event #{type}>"
    end
  end
end

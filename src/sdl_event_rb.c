#include "mruby.h"
#include "mruby/value.h"
#include "mruby/hash.h"
#include "mruby/variable.h"
#include "SDL.h"

void set_event_data(mrb_state *mrb, SDL_Event *event, mrb_value self) {
  mrb_iv_set(mrb, self, mrb_intern_lit(mrb, "@type"), mrb_fixnum_value(event->type));

  if (event->type < SDL_WINDOWEVENT || event->type == SDL_CLIPBOARDUPDATE)
    return;

  // mrb_value common = mrb_hash_new(mrb); // SDL_CommonEvent

  if (event->type < SDL_KEYDOWN) { // window events
    mrb_value window = mrb_hash_new(mrb);
    mrb_iv_set(mrb, self, mrb_intern_lit(mrb, "@window"), window);

    mrb_value symbol__timestamp = mrb_symbol_value(mrb_intern_lit(mrb, "timestamp"));
    mrb_hash_set(
      mrb,
      window,
      symbol__timestamp,
      mrb_fixnum_value(event->window.timestamp)
    );

    mrb_hash_set(
      mrb,
      window,
      mrb_symbol_value(mrb_intern_lit(mrb, "windowID")),
      mrb_fixnum_value(event->window.windowID)
    );

    mrb_hash_set(
      mrb,
      window,
      mrb_symbol_value(mrb_intern_lit(mrb, "event")),
      mrb_fixnum_value(event->window.event)
    );
  } else if (event->type < SDL_MOUSEMOTION) { // keyboard events
    mrb_value key = mrb_hash_new(mrb); // SDL_KeyboardEvent
    mrb_value edit = mrb_hash_new(mrb); // SDL_TextEditingEvent
    mrb_iv_set(mrb, self, mrb_intern_lit(mrb, "@key"), key);
    mrb_iv_set(mrb, self, mrb_intern_lit(mrb, "@edit"), edit);

    mrb_hash_set(
      mrb,
      key,
      mrb_symbol_value(mrb_intern_lit(mrb, "windowID")),
      mrb_fixnum_value(event->key.windowID)
    );

    mrb_hash_set(
      mrb,
      key,
      mrb_symbol_value(mrb_intern_lit(mrb, "state")),
      mrb_fixnum_value(event->key.state)
    );

    mrb_hash_set(
      mrb,
      key,
      mrb_symbol_value(mrb_intern_lit(mrb, "repeat")),
      mrb_fixnum_value(event->key.repeat)
    );

    mrb_value keysym = mrb_hash_new(mrb); // SDL_Keysym
    mrb_hash_set(mrb, key, mrb_symbol_value(mrb_intern_lit(mrb, "keysym")), keysym);

    mrb_hash_set(
      mrb,
      keysym,
      mrb_symbol_value(mrb_intern_lit(mrb, "scancode")),
      mrb_fixnum_value(event->key.keysym.scancode)
    );

    mrb_hash_set(
      mrb,
      keysym,
      mrb_symbol_value(mrb_intern_lit(mrb, "sym")),
      mrb_fixnum_value(event->key.keysym.sym)
    );

    mrb_hash_set(
      mrb,
      keysym,
      mrb_symbol_value(mrb_intern_lit(mrb, "mod")),
      mrb_fixnum_value(event->key.keysym.mod)
    );

    mrb_hash_set(
      mrb,
      edit,
      mrb_symbol_value(mrb_intern_lit(mrb, "windowID")),
      mrb_fixnum_value(event->edit.windowID)
    );

    // TODO: text

    mrb_hash_set(
      mrb,
      edit,
      mrb_symbol_value(mrb_intern_lit(mrb, "start")),
      mrb_fixnum_value(event->edit.start)
    );

    mrb_hash_set(
      mrb,
      edit,
      mrb_symbol_value(mrb_intern_lit(mrb, "length")),
      mrb_fixnum_value(event->edit.length)
    );

    mrb_value text = mrb_hash_new(mrb); // SDL_TextInputEvent

    mrb_hash_set(
      mrb,
      text,
      mrb_symbol_value(mrb_intern_lit(mrb, "windowID")),
      mrb_fixnum_value(event->text.windowID)
    );

    // TODO: text
  } else if (event->type < SDL_JOYAXISMOTION) { // mouse events
    mrb_value motion = mrb_hash_new(mrb); // SDL_MouseMotionEvent
    mrb_iv_set(mrb, self, mrb_intern_lit(mrb, "@motion"), motion);
    mrb_value button = mrb_hash_new(mrb); // SDL_MouseButtonEvent
    mrb_iv_set(mrb, self, mrb_intern_lit(mrb, "@button"), button);
    mrb_value wheel = mrb_hash_new(mrb); // SDL_MouseWheelEvent
    mrb_iv_set(mrb, self, mrb_intern_lit(mrb, "@wheel"), wheel);

    mrb_hash_set(
      mrb,
      motion,
      mrb_symbol_value(mrb_intern_lit(mrb, "windowID")),
      mrb_fixnum_value(event->motion.windowID)
    );

    mrb_hash_set(
      mrb,
      motion,
      mrb_symbol_value(mrb_intern_lit(mrb, "which")),
      mrb_fixnum_value(event->motion.which)
    );

    mrb_hash_set(
      mrb,
      motion,
      mrb_symbol_value(mrb_intern_lit(mrb, "state")),
      mrb_fixnum_value(event->motion.state)
    );

    mrb_hash_set(
      mrb,
      motion,
      mrb_symbol_value(mrb_intern_lit(mrb, "x")),
      mrb_fixnum_value(event->motion.x)
    );

    mrb_hash_set(
      mrb,
      motion,
      mrb_symbol_value(mrb_intern_lit(mrb, "y")),
      mrb_fixnum_value(event->motion.y)
    );

    mrb_hash_set(
      mrb,
      motion,
      mrb_symbol_value(mrb_intern_lit(mrb, "xrel")),
      mrb_fixnum_value(event->motion.xrel)
    );

    mrb_hash_set(
      mrb,
      motion,
      mrb_symbol_value(mrb_intern_lit(mrb, "yrel")),
      mrb_fixnum_value(event->motion.yrel)
    );

    mrb_hash_set(
      mrb,
      button,
      mrb_symbol_value(mrb_intern_lit(mrb, "windowID")),
      mrb_fixnum_value(event->button.windowID)
    );

    mrb_hash_set(
      mrb,
      button,
      mrb_symbol_value(mrb_intern_lit(mrb, "which")),
      mrb_fixnum_value(event->button.which)
    );

    mrb_hash_set(
      mrb,
      button,
      mrb_symbol_value(mrb_intern_lit(mrb, "button")),
      mrb_fixnum_value(event->button.button)
    );

    mrb_hash_set(
      mrb,
      button,
      mrb_symbol_value(mrb_intern_lit(mrb, "state")),
      mrb_fixnum_value(event->button.state)
    );

    mrb_hash_set(
      mrb,
      button,
      mrb_symbol_value(mrb_intern_lit(mrb, "clicks")),
      mrb_fixnum_value(event->button.clicks)
    );

    mrb_hash_set(
      mrb,
      button,
      mrb_symbol_value(mrb_intern_lit(mrb, "x")),
      mrb_fixnum_value(event->button.x)
    );

    mrb_hash_set(
      mrb,
      button,
      mrb_symbol_value(mrb_intern_lit(mrb, "y")),
      mrb_fixnum_value(event->button.y)
    );

    mrb_hash_set(
      mrb,
      wheel,
      mrb_symbol_value(mrb_intern_lit(mrb, "windowID")),
      mrb_fixnum_value(event->wheel.windowID)
    );

    mrb_hash_set(
      mrb,
      wheel,
      mrb_symbol_value(mrb_intern_lit(mrb, "which")),
      mrb_fixnum_value(event->wheel.which)
    );

    mrb_hash_set(
      mrb,
      wheel,
      mrb_symbol_value(mrb_intern_lit(mrb, "x")),
      mrb_fixnum_value(event->wheel.x)
    );

    mrb_hash_set(
      mrb,
      wheel,
      mrb_symbol_value(mrb_intern_lit(mrb, "y")),
      mrb_fixnum_value(event->wheel.y)
    );

    mrb_hash_set(
      mrb,
      wheel,
      mrb_symbol_value(mrb_intern_lit(mrb, "direction")),
      mrb_fixnum_value(event->wheel.direction)
    );
  } else if (event->type < SDL_CONTROLLERAXISMOTION) { // joystick events
    // mrb_value jaxis = mrb_hash_new(mrb); // SDL_JoyAxisEvent
    // mrb_value jball = mrb_hash_new(mrb); // SDL_JoyBallEvent
    // mrb_value jhat = mrb_hash_new(mrb); // SDL_JoyHatEvent
    // mrb_value jbutton = mrb_hash_new(mrb); // SDL_JoyButtonEvent
    // mrb_value jdevice = mrb_hash_new(mrb); // SDL_JoyDeviceEvent
  } else if (event->type < SDL_FINGERDOWN) { // game controller
    // mrb_value caxis = mrb_hash_new(mrb); // SDL_ControllerAxisEvent
    // mrb_value cbutton = mrb_hash_new(mrb); // SDL_ControllerButtonEvent
    // mrb_value cdevice = mrb_hash_new(mrb); // SDL_ControllerDeviceEvent
    // mrb_value ctouchpad = mrb_hash_new(mrb); // SDL_ControllerTouchpadEvent
    // mrb_value csensor = mrb_hash_new(mrb); // SDL_ControllerSensorEvent
  } else if (event->type < SDL_DOLLARGESTURE) { // touch events
    mrb_value tfinger = mrb_hash_new(mrb); // SDL_TouchFingerEvent
    mrb_iv_set(mrb, self, mrb_intern_lit(mrb, "@tfinger"), tfinger);

    mrb_hash_set(
      mrb,
      tfinger,
      mrb_symbol_value(mrb_intern_lit(mrb, "touchId")),
      mrb_fixnum_value(event->tfinger.touchId)
    );

    mrb_hash_set(
      mrb,
      tfinger,
      mrb_symbol_value(mrb_intern_lit(mrb, "fingerId")),
      mrb_fixnum_value(event->tfinger.fingerId)
    );

    mrb_hash_set(
      mrb,
      tfinger,
      mrb_symbol_value(mrb_intern_lit(mrb, "x")),
      mrb_float_value(mrb, event->tfinger.x)
    );

    mrb_hash_set(
      mrb,
      tfinger,
      mrb_symbol_value(mrb_intern_lit(mrb, "y")),
      mrb_float_value(mrb, event->tfinger.y)
    );

    mrb_hash_set(
      mrb,
      tfinger,
      mrb_symbol_value(mrb_intern_lit(mrb, "dx")),
      mrb_float_value(mrb, event->tfinger.dx)
    );

    mrb_hash_set(
      mrb,
      tfinger,
      mrb_symbol_value(mrb_intern_lit(mrb, "dy")),
      mrb_float_value(mrb, event->tfinger.dy)
    );

    mrb_hash_set(
      mrb,
      tfinger,
      mrb_symbol_value(mrb_intern_lit(mrb, "pressure")),
      mrb_float_value(mrb, event->tfinger.pressure)
    );

    mrb_hash_set(
      mrb,
      tfinger,
      mrb_symbol_value(mrb_intern_lit(mrb, "windowID")),
      mrb_fixnum_value(event->tfinger.windowID)
    );
  } else if (event->type < SDL_CLIPBOARDUPDATE) { // gesture events
    // mrb_value mgesture = mrb_hash_new(mrb); // SDL_MultiGestureEvent
    // mrb_value dgesture = mrb_hash_new(mrb); // SDL_DollarGestureEvent
  } else if (event->type < SDL_AUDIODEVICEADDED) { // drag and drop events
    // mrb_value drop = mrb_hash_new(mrb); // SDL_DropEvent
  } else if (event->type < SDL_SENSORUPDATE) { // audio device events
    // mrb_value adevice = mrb_hash_new(mrb); // SDL_AudioDeviceEvent
  } else if (event->type < SDL_RENDER_TARGETS_RESET) { // sensor events
    // mrb_value sensor = mrb_hash_new(mrb); // SDL_SensorEvent
  } else if (event->type < SDL_USEREVENT) { // render events

  } else if (event->type < SDL_LASTEVENT) { // user events
    // mrb_value user = mrb_hash_new(mrb); // SDL_UserEvent
  }

  // mrb_value display = mrb_hash_new(mrb); // SDL_DisplayEvent
  // mrb_value quit = mrb_hash_new(mrb); // SDL_QuitEvent
  // mrb_value syswm = mrb_hash_new(mrb); // SDL_SysWMEvent
}

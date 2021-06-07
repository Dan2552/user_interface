#include "mruby.h"
#include "mruby/hash.h"
#include "SDL.h"
#include "sdl_event_rb.h"

Uint64 user_interface_time_now = 0;
Uint64 user_interface_time_last = 0;

mrb_value user_interface_refresh_delta_time(mrb_state *mrb, mrb_value self) {
  if (user_interface_time_now == 0) {
    user_interface_time_now = SDL_GetPerformanceCounter();
    user_interface_time_last = user_interface_time_now;
    return mrb_float_value(mrb, 0);
  }

  user_interface_time_last = user_interface_time_now;
  user_interface_time_now = SDL_GetPerformanceCounter();

  double delta = (
    user_interface_time_now - user_interface_time_last
    ) / (double)SDL_GetPerformanceFrequency();

  return mrb_float_value(mrb, delta);
}

mrb_value user_interface_events(mrb_state *mrb, mrb_value self) {
  mrb_value proc;
  mrb_get_args(mrb, "&", &proc);
  SDL_Event event;
  struct RClass *user_interace_rb = mrb_module_get(mrb, "UserInterface");
  struct RClass *event_rb = mrb_class_get_under(mrb, user_interace_rb, "Event");



  while (SDL_PollEvent(&event)) {
    mrb_value event_rb_instance = mrb_obj_new(mrb, event_rb, 0, NULL);
    set_event_data(mrb, &event, event_rb_instance);
    mrb_yield(mrb, proc, event_rb_instance);
  }

  return mrb_nil_value();
}

mrb_value user_interface_sleep(mrb_state *mrb, mrb_value self) {
  mrb_float rb_delay;
  mrb_get_args(mrb, "f", &rb_delay);

  SDL_Delay(rb_delay * 1000);

  return mrb_nil_value();
};

void mrb_mruby_user_interface_gem_init(mrb_state *mrb) {
  struct RClass *user_interace_rb = mrb_define_module(mrb, "UserInterface");
  mrb_define_class_method(mrb, user_interace_rb, "refresh_delta", user_interface_refresh_delta_time, MRB_ARGS_NONE());

  struct RClass *event_rb = mrb_define_class_under(mrb, user_interace_rb, "Event", mrb->object_class);
  mrb_define_class_method(mrb, event_rb, "poll", user_interface_events, MRB_ARGS_NONE());

  struct RClass *object = mrb_class_get(mrb, "Object");
  mrb_define_method(mrb, object, "sleep", user_interface_sleep, MRB_ARGS_REQ(1));

  if (SDL_Init(SDL_INIT_VIDEO) < 0)
    mrb_raise(mrb, E_RUNTIME_ERROR, "SDL_Init failed");
}

void mrb_mruby_user_interface_gem_final(mrb_state *mrb) {
  SDL_Quit();
}

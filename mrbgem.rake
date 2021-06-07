MRuby::Gem::Specification.new("mruby-user_interface") do |spec|
  load "#{__dir__}/mruby/load.rb"

  spec.license = "MIT"
  spec.authors = "Daniel Inkpen"
  spec.rbfiles = files("user_interface")

  # TODO: figure out this, especially to be different per platform?
  sdl_install = "/Users/dan2552/.avian/build/desktop/install"

  spec.cc.flags << "-I#{sdl_install}/include/SDL2"
  spec.linker.flags << "-L#{sdl_install}/lib -lSDL2"

  spec.add_dependency("mruby-core_graphics", path: File.join(Dir.pwd, "../core_graphics"))
  spec.add_dependency("mruby-core_structures", path: File.join(Dir.pwd, "../core_structures"))
end

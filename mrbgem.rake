MRuby::Gem::Specification.new("mruby-user_interface") do |spec|
  load "#{__dir__}/mruby/load.rb"

  spec.license = "MIT"
  spec.authors = "Daniel Inkpen"
  spec.rbfiles = files("user_interface")

  # conf.cc do |cc|
  #   cc.flags << "-I/_path_/_to_/_SDL_/include/SDL2"
  # end
  #
  # conf.linker do |linker|
  #   linker.flags << "-L/_path_/_to_/_SDL_/lib -lSDL2 -lSDL2_image -lSDL2_ttf"
  # end
  spec.requirements = "SDL in compiler and linker flags"

  if (path = ENV["CORE_GRAPHICS_PATH"])
    spec.add_dependency("mruby-core_graphics", path: path)
  else
    spec.add_dependency("mruby-core_graphics", github: "Dan2552/core_graphics")
  end

  if (path = ENV["CORE_STRUCTURES_PATH"])
    spec.add_dependency("mruby-core_structures", path: path)
  else
    spec.add_dependency("mruby-core_structures", github: "Dan2552/core_structures")
  end
end

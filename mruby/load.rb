def files(base_file)
  files = []

  project_dir = File.expand_path(File.join(__dir__, ".."))
  stubs = File.join(project_dir, "mruby", "stubs.rb")
  base = File.join(project_dir, "lib", "#{base_file}.rb")
  files = [stubs, base]

  File.read(base).each_line do |line|
    next unless line.start_with?("require")
    r = line.split('"')[1]
    files << File.join(project_dir, "lib", "#{r}.rb")
  end

  files
end

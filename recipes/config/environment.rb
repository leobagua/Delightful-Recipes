require_relative 'application'

Dir.glob(
  [
    File.join('**', 'initializers', '**', '*.rb')
  ]
).each do |path|
  require_relative File.expand_path(path)
end

Dir.glob(File.join('**', 'app', '**', '*.rb')).sort.each do |path|
  require File.expand_path(path)
end

set :root, File.expand_path('app')
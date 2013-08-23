Ground do
  set :logger, ::Logger.new(STDOUT)
  set :root, File.expand_path(File.dirname(File.dirname(__FILE__)))
end

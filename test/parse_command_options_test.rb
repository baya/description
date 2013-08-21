require 'test_helper'

class ParseCommandOptionsTest < Test::Unit::TestCase
  puts ARGV.inspect

  def test_parse_command_options
    options = ParseCommandOptions(args: ["-p", "9898", "-m", "db/migrations"])
    assert_equal options, {:port=>"9898", :migration_dir=>"db/migrations"}
  end
  
end

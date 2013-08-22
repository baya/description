require 'test_helper'

class ParseCommandOptionsTest < Test::Unit::TestCase
  puts ARGV.inspect

  def test_parse_command_options
    options = ParseCommandOptions(args: ["-p", "9898", "-s", "thin"])
    assert_equal options, {:port=>"9898", :server => 'thin'}
  end
  
end

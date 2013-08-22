class ParseCommandOptions < Dun::Activity

  data_reader :args

  def call
    options = {}
    opt_parser = OptionParser.new do |opts|

      opts.banner = "Usage: describle path/to/migration-files-dir [options]"
      
      options[:port] = '9393'
      opts.on("-p", "--port PORT", "use PORT (default: 9393)") {|port|
        options[:port] = port
      }

      options[:server] = 'webrick'
      opts.on("-s", "--server SERVER", "server using SERVER (default: webrick)") {|server|
        options[:server] = server
      }

      opts.on("-h", "--help", "Show this message") {
        puts opts
        exit
      }
      
    end

    opt_parser.parse! args

    options
    
  end
  
end

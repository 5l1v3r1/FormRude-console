



module FormRude
module Ui
module Console
module Shell
module Commands

  class Set
    attr_accessor :sub_cmd_ary

    def initialize
      self.sub_cmd_ary = commands.keys.sort
    end

    #
    # Contains command information
    # @return [Hash] {command => Description}
    #
    def self.info
      {'set' => 'Sets a variable to a value'}
    end

    # Command usage
    def self.usage
      puts %Q{Usage: set option_name}
    end

    #
    # A hash of inner commands in show
    # The hash keys: all, exploits, @param[payloads], encoders, wiki
    #
    def commands

      {
          'TODO' => "This one shout take its sub commands from current(headers/body) variables and the key value should be the command description
                      This one should depend on current context"
      }

    end

    #
    # Just what the command use to do
    #
    def action
      puts "use command!\n\n"
    end

  end # Set

end # Commands
end # Shell
end # Console
end # UI
end # FormRude
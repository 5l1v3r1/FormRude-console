#
#
#


module FormRude
module Ui
module Console
module Shell
module Commands
  class Exit
    #include Xss::Ui::Console::Shell::Commands

    attr_accessor :sub_cmd_ary

    def initialize
      self.sub_cmd_ary = commands.keys.sort
    end

    #
    # Contains command information
    # @return [Hash] {command => Description}
    #
    def self.info
      {'exit' => 'Exit the console'}
    end

    # Command usage
    def self.usage
      puts %Q{Just type exit, to exit :)}
    end

    #
    # A hash of inner commands in update
    #
    def commands
      {}
    end

    #
    # Just what the command use to do
    #
    def action
      puts "See you soon ;)\n\n"
      exit
    end

  end # Exit
end # Commands
end # Shell
end # Console
end # UI
end # FormRude

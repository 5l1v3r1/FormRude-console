#
#
#


module FormRude
module Ui
module Console
module Shell
module Commands

  class Back
    attr_accessor :sub_cmd_ary

    def initialize
      self.sub_cmd_ary = commands.keys.sort
    end

    #
    # Contains command information
    # @return [Hash] {command => Description}
    #
    def self.info
      {'back' => 'one step up'}
    end

    # Command usage
    def self.usage
      puts %Q{back}
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
    def action(path = nil)
      puts "See you soon ;)\n\n"
      exit
    end
  end # Back

end # Commands
end # Shell
end # Console
end # UI
end # FormRude

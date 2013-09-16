#
#
#


module FormRude
module Ui
module Console
module Shell
module Commands

  class Help

    attr_accessor :sub_cmd_ary

    def initialize
      @commands = CommandsCore.instance_methods(false).map do |cmd|
        next unless cmd.to_s.include?("cmd_")
        cmd.to_s.split("_").last
      end.delete_if {|e| e.nil?}.sort!

      # @return [Array] of sub-commands
      self.sub_cmd_ary = commands.keys.sort
    end

    #
    # Contains command information
    # @return [Hash] {command => Description}
    #
    def self.info
      {'help' => 'Help menu - Show This screen'}
    end

    #
    # Command usage
    #
    def self.usage
      puts %Q{WTF! Are you asking help for help?!\nhelp command }
    end

    #
    # Goes through each command class and get information,
    # <b>only <i>help</i> will get its commands from info</b>
    # @return [Hash]
    #
    def commands
      help_list = {}
      @commands.map do |cmd|
        info = Commands.const_get("#{cmd}".capitalize!).info   #=> {cmd => "Description"}
        help_list[info.keys.first] = info.values.first
      end

      return help_list
    end

    #
    # Just what the command use to do
    #
    def action
      puts "\nHelp menu"
      puts '=' * 'Help menu'.length + "\n\n"
      puts "   Command \t Description"
      puts "   " + '-' * 'Command'.length + " \t " + '-' * 'Description'.length
      commands.map {|cmd , desc| puts "   #{cmd}    \t #{desc}"}
      puts "\n\n"
    end

  end # Help

end # Commands
end # Shell
end # Console
end # UI
end # FormRude

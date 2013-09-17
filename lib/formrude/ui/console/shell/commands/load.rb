#
#
#


module FormRude
module Ui
module Console
module Shell
module Commands

  class Load

    attr_accessor :sub_cmd_ary

    def initialize
      self.sub_cmd_ary = commands.keys.sort
    end

    #
    # Contains command information
    # @return [Hash] {command => Description}
    #
    def self.info
      {'load' => 'Loads post file'}
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

    def file_summary(file, file_path)
      @@parse = FormRude::Ui::Console::Operations::HTTP::PostParser.new(file)

      # File summary
      puts "[+] ".light_green + "File Summary".white
      puts " - ".green + "Post file name: "      + "#{file_path.split('/').last}".bold
      puts " - ".green + "Number of headers: "   + "#{@@parse.headers.length}".bold + " headers"
      puts " - ".green + "Number of variables: " + "#{@@parse.body.length}".bold    + " variables"
      puts ""
    end


    #
    # Just what the command use to do
    #
    def action(file_path = nil)
      begin
        if file_path and File.exists?(file_path)
          file = File.read(file_path)
        elsif file_path == "load"
          puts "[!] ".yellow.bold + "Please mention post file.\n"
        end

        file_summary(file , file_path)
      rescue
        puts "[!] ".red.bold + "#{file_path}".underline + ": No such file!\n\n"
      end
      pp @@parse.parse
      return @@parse.parse
    end

  end # Load

end # Commands
end # Shell
end # Console
end # UI
end # FormRude

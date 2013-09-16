
require_list = Dir.glob("lib/formrude/ui/console/shell/commands/*.rb").map {|lib| lib.split("/").last.gsub(".rb" , "")}
require_list.each do |lib|
  require "formrude/ui/console/shell/commands/#{lib}"
end


module FormRude
module Ui
module Console
module Shell
module Commands

  #
  # [CommandsCore] class calling all commands
  #
  class CommandsCore

    def initialize
        @show = Show.new(nil)
    end


    def cmd_show(cmd)
        @show.action(cmd)
    end

    def cmd_use(cmd)

    end

    def cmd_back(cmd=nil)
      exit 1
    end


  end

end
end # Shell
end # Console
end # UI
end # FormRude

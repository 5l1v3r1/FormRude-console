
require_list = Dir.glob("#{Dir.pwd}/lib/formrude/ui/console/shell/commands/*.rb").map {|lib| lib.split("/").last.gsub(".rb" , "")}
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

    include FormRude::Ui::Console::Prints::Decoration

    def initialize#(context)
      pp @context = FormRude::Ui::Console::Shell::Context.new
      @load = Load.new
      @show = Show.new(nil)
      @exit = Exit.new
    end

    def cmd_load(path)
      @load.action(path.last)
    end

    def cmd_show(*cmd)
      @context.send(@show.action(cmd))
    end

    def cmd_use(*cmd)

    end

    def cmd_set(*cmd)

    end

    def cmd_back(cmd=nil)
      #exit 1
    end

    def cmd_exit(cmd=nil)
      @exit.action
    end


  end # CommandsCore

end
end # Shell
end # Console
end # UI
end # FormRude

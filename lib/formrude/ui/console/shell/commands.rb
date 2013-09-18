
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
      @context = FormRude::Ui::Console::Shell::Context.new
      @load = Load.new
      @show = Show.new
      @back = Back.new
      @exit = Exit.new
    end

    def cmd_load(path)
      @load.action(path.last)
      @context.current_context = @load.post_parse    # Initiation for current context value
    end

    def cmd_show(cmd)
      # TODO : MAKE SURE THAT THE POST FILE IS LOADED
      if  @context.current_context.empty?
        puts "[!] ".red + "Post file is not loaded. please use 'load' command to load it"
      else
        @show.action(@context.current_context, cmd.last)
      end
    end

    def cmd_use(*cmd)

    end

    def cmd_set(*cmd)

    end

    def cmd_back(cmd=nil)
      @back.action
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

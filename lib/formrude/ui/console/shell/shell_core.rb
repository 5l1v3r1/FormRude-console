
module FormRude
module Ui
module Console
module Shell

  #
  # [Prompt] class is a core for console's [Shell] *prompt*
  #
  class Prompt

    include FormRude::Ui::Console::Prints::Decoration

    def initialize#(post)
      #@post = post
      @shell_config = Config.new
    end

    #
    # Start prompt
    #
    def start
      begin

        while true
          line = ""

          @shell_config.tab_completion
          line = ::Readline.readline('FormRude'.white + ' -> '.red , true)
          unless @shell_config.run_command(line) == false
            @shell_config.history(line)
          end

        end

      rescue Interrupt
        #puts_debug "Use 'exit' command to quit!"
        puts "Use 'exit' command to quit!"
        #retry
      end

    end

  end # Prompt

end # Shell
end # Console
end # UI
end # FormRude


require 'formrude/ui/console/shell/commands'

module FormRude
module Ui
module Console
module Shell

  #
  # [Config] class a central placeholder for general console configurations
  #
  class Config

    include FormRude::Ui::Console::Prints::Decoration
    include FormRude::Ui::Console::Shell::Commands

    def initialize
      require 'readline'
      @history = FormRude::Ui::Console::Shell::History.new
      @file    = File.open(@history.history_file, 'a')
      @commandsCore = CommandsCore.new
      # TODO : to add the current stack to current context

    end

    #
    # Shell history configurations
    #
    def history(line)
      @file.puts(line) unless @history.line_repeated?(line)
    end

    #
    # Send command to command call in CommandsCore be executed
    #
    def run_command(cmd)
      cmd = cmd.split
      # Check if entered command exists in CommandsCore
      if @commandsCore.respond_to?("cmd_#{cmd.first}")
        # Send [Array] of argument(s) -w/out cmd- to the command - command will handle it
        @commandsCore.send("cmd_#{cmd.first}", cmd[1..-1])
      elsif cmd.empty?
        # Do nothing
      else
        puts_err "#{cmd.first}: Command not found!"
        return false
      end
    end

    #
    # Tab completion
    #
    MAIN = ['help', 'load']
    def tab_completion
      ::Readline.completion_append_character = ' '
      ::Readline.basic_word_break_characters = "\x00"

      comp = proc do |s|

        Readline.line_buffer.split # line_buffer is the contents of line during pressing tab @return [String]

        if Readline.line_buffer =~ /help.*\s+/i
            Help.new.sub_cmd_ary.grep(/^#{Regexp.escape(s.sub(%r{^help\s+}i, ''))}/i) { |subs| "help #{subs}" }
        elsif Readline.line_buffer =~ /load.*\s+/i
          ::Readline.completion_proc = nil # Dir.entries #Load.new.sub_cmd_ary.grep(/^#{Regexp.escape(s.sub(%r{^load\s+}i, ''))}/i) { |subs| ::Readline.completion_proc = nil }
          #p  Readline.line_buffer.split.last
        elsif Readline.line_buffer =~ /show.*\s+/i
            Show.new.sub_cmd_ary.grep(/^#{Regexp.escape(s.sub(%r{^show\s+}i, ''))}/i) { |subs| "show #{subs}" }
        elsif Readline.line_buffer =~ /use.*\s+/i
            Use.new.sub_cmd_ary.grep(/^#{Regexp.escape(s.sub(%r{^use\s+}i, ''))}/i) { |subs| "use #{subs}" }
        elsif Readline.line_buffer =~ /set.*\s+/i
            Set.new.sub_cmd_ary.grep(/^#{Regexp.escape(s.sub(%r{^set\s+}i, ''))}/i) { |subs| "set #{subs}" }
        else
          MAIN.grep(/^#{Regexp.escape(s.sub(%r{^set\s+}i, ''))}/i)
            # Should show look at context
        end

        #case s
        #  when Readline.line_buffer =~ /help.*\s+/i
        #    Help.new.sub_cmd_ary.grep(/^#{Regexp.escape(s.sub(%r{^help\s+}i, ''))}/i) { |subs| "help #{subs}" }
        #  when Readline.line_buffer =~ /load.*\s+/i
        #    ::Readline.completion_proc = nil
        #  when Readline.line_buffer =~ /show.*\s+/i
        #    Show.new.sub_cmd_ary.grep(/^#{Regexp.escape(s.sub(%r{^show\s+}i, ''))}/i) { |subs| "show #{subs}" }
        #  when Readline.line_buffer =~ /use.*\s+/i
        #    Use.new.sub_cmd_ary.grep(/^#{Regexp.escape(s.sub(%r{^use\s+}i, ''))}/i) { |subs| "use #{subs}" }
        #  when Readline.line_buffer =~ /set.*\s+/i
        #    Set.new.sub_cmd_ary.grep(/^#{Regexp.escape(s.sub(%r{^set\s+}i, ''))}/i) { |subs| "set #{subs}" }
        #  else
        #    #::Readline.completion_proc = nil
        #    # Should show look at context
        #    MAIN.grep(/^#{Regexp.escape(s.sub(%r{^set\s+}i, ''))}/i)
        #end

      end

      ::Readline.completion_proc = comp #completion
    end



  end # Config

end # Shell
end # Console
end # UI
end # FormRude


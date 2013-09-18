#
#
#
require 'terminal-table'

module FormRude
module Ui
module Console
module Shell
module Commands
  class Show

    attr_accessor :sub_cmd_ary , :current_context

    def initialize
      self.sub_cmd_ary = commands.keys.sort
    end

    #
    # Contains command information
    # @return [Hash] {command => Description}
    #
    def self.info
      {'show' => 'Displays variables & values of a given type, or the full post'}
    end

    # Command usage
    def self.usage
      puts %Q{Usage: show [headers|body|full_post]}
    end

    #
    # A hash of inner commands in show
    # The hash keys: all, exploits, @param[payloads], encoders, wiki
    #
    def commands
      {
          'headers'   => 'Show post headers.',
          'body'      => 'Show post body.',
          'full_post' => 'Show full post, headers & body.'
      }
    end

    #
    # Shows post headers in table
    #
    def show_headers
      hrows = []
      current_context[0][:headers].map do |hash|
        hash.each do |_key , _val|
          _val = _val.scan(/.{100}/).join("\n") if _val.size > 150    # This line To fix table layout

          hrows << ["#{_key}".green , "#{_val}".white]
          hrows << :separator
        end
      end

      return hrows
    end

    #
    # Shows post body in table
    #
    def show_body
      brows = []
      current_context[0][:body].map do |hash|
        hash.each do |_key , _val|
          _val = _val.scan(/.{100}/).join("\n") if _val.size > 150    # This line To fix table layout

          brows << ["#{_key}".green, "#{_val}".white]
          brows << :separator
        end
      end

      return brows
    end

    #
    # Shows the full post headers & body in table
    #
    def show_full
      frows = []
      frows << show_headers
      #frows << show_body

      return frows
    end


    #
    # Just what the command use to do
    #
    def action(current_context, cmd_arg=nil)
      self.current_context = current_context

      tables =
          {
           "headers" =>
               Terminal::Table.new(
                  :title    => "Headers".bold.underline,
                  :headings => ["Header".bold, "Value".bold],
                  :rows     => show_headers),
           "body" =>
               Terminal::Table.new(
                  :title    => "Body".bold.underline,
                  :headings => ["Variable".bold, "Value".bold],
                  :rows     => show_body),
           "full_post" =>
               Terminal::Table.new(
                  :title    => "Full post".bold.underline,
                  :headings => ["Variable".bold, "Value".bold],
                  :rows     => show_full)
          }

      if cmd_arg == "#{cmd_arg}"
        puts tables["#{cmd_arg}"]
      else
        cmd_arg = current_context
        puts tables["#{cmd_arg}"]
      end

    end

  end  # Show

end # Commands
end # Shell
end # Console
end # UI
end # FormRude

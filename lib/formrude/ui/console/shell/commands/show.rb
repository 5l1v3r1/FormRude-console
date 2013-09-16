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

    attr_accessor :sub_cmd_ary

    def initialize(context)
      self.sub_cmd_ary = commands.keys.sort
      @context = context

      @hrows = []
      @brows = []
      @frows = []
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
      @context.current_context[0][:headers].map do |hash|
        hash.each do |_key , _val|
          _val = _val.scan(/.{100}/).join("\n") if _val.size > 150    # This line To fix table layout

          @hrows << ["#{_key}".green , "#{_val}".white]
          @hrows << :separator
        end
      end

      #htable = Terminal::Table.new(:title => "Headers".bold.underline, :headings => ["Header".bold, "Value".bold], :rows => @hrows)
    end

    #
    # Shows post body in table
    #
    def show_body
      @context.current_context[0][:body].map do |hash|
        hash.each do |_key , _val|
          _val = _val.scan(/.{100}/).join("\n") if _val.size > 150    # This line To fix table layout

          @brows << ["#{_key}".green, "#{_val}".white]
          @brows << :separator
        end
      end

      #btable = Terminal::Table.new(:title => "Body".bold.underline, :headings => ["Variable".bold, "Value".bold], :rows => @brows)
    end

    #
    # Shows the full post headers & body in table
    #
    def show_full
      @hrows << [show_headers , show_body]
    end

    #
    # Just what the command use to do
    #
    def action(value)
      value = nil if value == "show"

      tables =
          [
              Terminal::Table.new(:title => "Headers".bold.underline, :headings => ["Header".bold, "Value".bold], :rows => @hrows),
              Terminal::Table.new(:title => "Body".bold.underline, :headings => ["Variable".bold, "Value".bold], :rows => @brows),
              Terminal::Table.new(:title => "Full post".bold.underline, :headings => ["Variable".bold, "Value".bold], :rows => @frows)
          ]

      case
        when value == "headers"
          puts tables[0]
        when value == "body"
          puts tables[1]
        when value == "full_post"
          puts tables[2]
        else
          # TODO check current context if in body then show shows the body, if in headers then show headers and so on..
          pp @context.current_context
      end

    end

  end  # Show

end # Commands
end # Shell
end # Console
end # UI
end # FormRude

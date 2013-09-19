#
#
# 


module FormRude
module Ui
module Console
module Shell

  #
  # [Context] class controls console activity stack
  #
  class Context
    attr_accessor :current_context
    attr_accessor :parent_context

    def initialize#(current_context, parent_context)
      self.current_context = []
      #p "current", self.current_context = []
      self.parent_context  = []
      #p "parent" , self.parent_context  = []
    end

    def change_context(context = nil)
      if context == "back"
        self.parent_context
      end
    end


    #
    # Will need it in tab completion, later
    #
    def current_context_to_array
      case
        when self.current_context.kind_of?(Array)
          self.current_context.map { |item| item.keys }.join(' ') # TODO to be tested with join "\n"
        when self.current_context.kindof?(Hash)
          self.current_context.keys.join(' ')
        else
          self.current_context.current_context_to_array
      end
    end

    def item

    end


  end # Context

end # Shell
end # Console
end # UI
end # FormRude

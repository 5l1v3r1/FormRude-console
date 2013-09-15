begin
  require 'formrude/ui/console/prints'
  require 'formrude/ui/console/shell'
  require 'formrude/ui/console/context'
  require 'formrude/ui/console/operations'
rescue Exception => e
  puts "\n[!] Error from File: #{__FILE__} : #{e}\n\n"
end


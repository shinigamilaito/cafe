module Jasper
  
  class Generator
    include RbConfig
  
    def self.generate_report(xml_data, report_design, output_type, select_criteria)
      report_design << '.jasper' if !report_design.match(/\.jasper$/)
      
      dir = "#{Rails.root}/lib/jasper-bridge/jasper-reports"
      classpath = "#{dir}/bin"
        
      case CONFIG['host']
      when /mswin32/,/mingw32/
        Dir.foreach("#{dir}/lib") do |file|
          classpath << ";#{dir}/lib/"+file if (file != '.' and file != '..' and file.match(/\.jar$/))
        end
      else
        Dir.foreach("#{dir}/lib") do |file|
          classpath << ":#{dir}/lib/"+file if (file != '.' and file != '..' and file.match(/\.jar$/))
        end
      end
        
      pipe = IO.popen "java -cp \"#{classpath}\" XmlJasperInterface -o:#{output_type} -f:reports/#{report_design} -x:#{select_criteria}", "w+b" 
      pipe.write xml_data
      pipe.close_write
      result = pipe.read
      pipe.close
      result
    end
    
  end

end

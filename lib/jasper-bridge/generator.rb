module Jasper
  
  class Generator
    include RbConfig
    
    def self.export_jasper_file(jasper_file, xml_data, parent_node_xml, file_type)
      jasper_file << '.jasper' if !jasper_file.match(/\.jasper$/)
      
      classpath = generate_classpath
        
      pipe = IO.popen "java -cp \"#{classpath}\" InterfaceJasperXML reports/#{jasper_file} NA #{parent_node_xml} #{file_type} Y", "w+b" 
      pipe.write xml_data
      pipe.close_write
      pipe.close
    end
  
    def self.generate_classpath
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
      
      return classpath
    end    
  end
end

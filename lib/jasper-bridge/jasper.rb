require "jasper-bridge/generator" 

module Jasper
  module Bridge
    
  protected
  
    def send_file_pdf(file_name, jasper_file, xml_data, parent_node_xml)
      file_pdf = "#{jasper_file}.pdf"
      Generator.export_jasper_file(jasper_file, xml_data, parent_node_xml, 'pdf')      
      send_file("#{Rails.root}/reports/#{file_pdf}", filename: "#{file_name}.pdf", disposition: :inline)
    end
    
    def send_file_xls(file_name, jasper_file, xml_data, parent_node_xml)
      file_xls = "#{jasper_file}.xls"
      Generator.export_jasper_file(jasper_file, xml_data, parent_node_xml, 'xls')      
      send_file("#{Rails.root}/reports/#{file_xls}", filename: "#{file_name}.xls")
    end
    
    def send_file_xlsx(file_name, jasper_file, xml_data, parent_node_xml)
      file_xlsx = "#{jasper_file}.xlsx"
      Generator.export_jasper_file(jasper_file, xml_data, parent_node_xml, 'xlsx')   
      send_file("#{Rails.root}/reports/#{file_xlsx}", filename: "#{file_name}.xlsx")
    end
    
    def send_file_html(file_name, jasper_file, xml_data, parent_node_xml)
      file_html = "#{jasper_file}.html"
      Generator.export_jasper_file(jasper_file, xml_data, parent_node_xml, 'html')   
      send_file("#{Rails.root}/reports/#{file_html}", filename: "#{file_name}.html", disposition: :inline)
    end
    
    def send_file_docx(file_name, jasper_file, xml_data, parent_node_xml)
      file_docx = "#{jasper_file}.docx"
      Generator.export_jasper_file(jasper_file, xml_data, parent_node_xml, 'docx')   
      send_file("#{Rails.root}/reports/#{file_docx}", filename: "#{file_name}.docx")      
    end
    
  end
end

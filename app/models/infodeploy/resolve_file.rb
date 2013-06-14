require 'rexml/document'
module Infodeploy
  class ResolveFile
    @admin_titles="#{Rails.root.to_s}/public/documents/admin_model.xml"
    @admin_navicates="#{Rails.root.to_s}/public/documents/admin_navicate.xml"
    def self.get_admin_navicates
      nodes=main_node(@admin_titles,'models')
      admin_nodes=main_node(@admin_navicates,'navicates')
      navicates=Array.new
      nodes.each_element('model') do |n|
        title=n.elements['title'].text
        model_title={:title => n.elements['title'].text,:navicates => []}
        admin_nodes.each_element('navicate') do |an|
          if n.elements['marked'].text == an.elements['marked'].text
            model_title[:navicates].push({:title => an.elements['title'].text,:url => an.elements['url'].text})
          else
            navicates
          end
        end
        navicates.push(model_title)
      end
      navicates
    end
    
    private
    def self.main_node path,node
      xml=REXML::Document.new(File.open(path))
      return xml.elements[node]
    end
  end
end

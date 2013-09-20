Redmine::Plugin.register :dotgee_theme do
  name 'Dotgee Theme plugin'
  author 'Author name'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'
end

# Redéfinition de la méthode render_single_menu_node pour intégrer les pictos dans le 
# menu 'Admin'.
                      
module Redmine
  module MenuManager
    module MenuHelper
      def render_single_menu_node(item, caption, url, selected)
        link_text = h(caption)
        link_text = "<span class='entypo #{item.html_options[:class]}'></span>" + link_text if item.html_options[:picto]
        return link_to(link_text.html_safe, url, item.html_options(:selected => selected))
      end 
 
# Redéfinition de la méthode render_menu pour l'affichage du top_menu dans la navbar. 

        def render_menu(menu, project=nil) 
          links = []
          menu_items_for(menu, project) do |node|
            links << render_menu_node(node, project)
        end
        if (menu == :project_menu)
        links.empty? ? nil : content_tag('ul', links.join("").html_safe, :class => 'nav nav-tabs nav-stacked')
        else
        links.empty? ? nil : content_tag('ul', links.join("").html_safe, :class => 'nav navbar')     
       end
     end  
   end
  end
end
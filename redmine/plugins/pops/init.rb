Redmine::Plugin.register :pops do
  name 'Pops plugin'
  author 'Bassem Jellali'
  description 'A plugin for scientists projects'
  version '0.0.1'
  
  permission :pops, { :pops => [:index, :vote] }, :public => true
  menu :project_menu, :pops, {:controller => 'pops', :action => 'index' }, :caption => 'Interview', :after => :activity, :param => :project_id
  
  permission :needs, { :needs => [:index, :vote] }, :public => true
  menu :project_menu, :needs, {:controller => 'needs', :action => 'index' }, :caption => 'Besoins', :after => :activity, :param => :project_id
  
  permission :view_polls, :polls => :index
  permission :vote_polls, :polls => :vote

end

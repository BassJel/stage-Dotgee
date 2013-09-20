class PopsController < ApplicationController
  unloadable

  before_filter :find_project, :authorize, :only => :index

  def index
    #@project = Project.find(params[:project_id])
    @pops = Pop.find(:all) # @project.pops 
  end

  def vote
    pop = Pop.find(params[:id])
    pop.vote(params[:answer])
    if pop.save
      flash[:notice] = 'Vote saved'
    end
    redirect_to :action => 'index'
  end

  private 

  def find_project
    @project = Project.find(params[:project_id])
  end
end

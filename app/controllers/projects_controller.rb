class ProjectsController < ApplicationController

  def index
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    binding.pry
    if @project.save
      redirect_to project_path(@project)
    else
      render :new
    end
  end

  def show
    @project = find_project
  end

  private

  def project_params
    params.require(:project).permit(:title, :description, category_ids:[])  
  end

  def find_project
    Project.find(params[:id])
  end


end

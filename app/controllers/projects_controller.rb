class ProjectsController < ApplicationController

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      @project.user_id = current_user.id
      @project.save
      redirect_to project_path(@project)
    else
      render :new
    end
  end

  def show
    @project = find_project
  end

  def edit
    @project = find_project
  end

  def update
    @project = find_project
    if current_user
      @project.update(project_params)
      redirect_to project_path
    else
      flash[:notice] = "You are not authorized to edit this project"
      redirect to edit_project_path
    end
  end

  private

  def project_params
    params.require(:project).permit(:title, :description, category_ids:[], categories_attributes: [:name])
  end

  def find_project
    Project.find(params[:id])
  end


end

class CommentsController < ApplicationController

  def new
    @comment = Comment.new(project_id: params[:project_id])
  end

  def create
    @comment = Comment.create(comment_params)
    redirect_to project_path(@comment.project_id)
  end

  def comment_params
    params.require(:comment).permit(:description, :project_id)
  end
end

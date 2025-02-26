# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :set_project, only: [ :show, :update ]

  def index
    @projects = Project.all
  end

  def show
    @comments = @project.comments.includes(:user)
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      respond_to do |format|
        format.html { redirect_to projects_path, notice: "Project created!" }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @project.update(project_params)
      respond_to do |format|
        format.html { redirect_to @project, notice: "Project updated successfully." }
        format.turbo_stream
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :description, :status)
  end
end

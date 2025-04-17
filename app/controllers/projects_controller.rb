# frozen_string_literal: true

class ProjectsController < ApplicationController
  include Pagy::Backend

  before_action :authorize_project, only: [ :show, :update ]
  before_action :set_project, only: [ :show, :update ]

  def index
    authorize_project
    @projects = Project.all
  end

  def show
    @pagy, @comments = pagy(@project.comments.includes(:user).order(created_at: :asc), items: 10)

    respond_to do |format|
      format.html
      format.turbo_stream { render partial: "projects/comments_frame", locals: { project: @project, comments: @comments, pagy: @pagy } }
    end
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    authorize_project
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

  def authorize_project
    authorize @project || Project
  end

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :description, :status)
  end
end

# frozen_string_literal: true

# TasksController
class TasksController < ApplicationController
  def index

  end

  def show
    @tasks = Task.all.order('id desc')
    render json: @tasks
  end

  def store
    data = params[:data]
    Task.create!(title: data[:title], done: data[:done])
  end

  def update
    data = params[:data]
    task = Task.find(params[:id])
    task.done = data[:done]
    task.save
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
  end
end

# frozen_string_literal: true

# TasksController
class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def store
    task = Task.new
    task.title = params[:title]
    task.status = 'todo'
    task.save
    redirect_to '/tasks', notice: 'タスクを作成しました。'
  end

  def update
    task = Task.find(params[:id])
    task.status = 'done'
    task.save
    redirect_to '/tasks', notice: 'タスク状態を更新しました。'
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
    redirect_to '/tasks', notice: 'タスクを削除しました。'
  end
end

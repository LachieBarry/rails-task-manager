class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    # See all restaurants
    @tasks = Task.all
  end

  def show
    # See details about one restaurant
    set_task
  end

  def new
    # Create a restaurant (I)
    @task = Task.new
  end

  def create
    # Create a restaurant (II)
    @task = Task.new(task_params)
    # raise
    @task.save
    redirect_to task_path
  end

  def edit
    # Update a restaurant (I)
    set_task
  end

  def update
    # Update a restaurant (II)
    set_task
    @task.update(task_params)
    redirect_to task_path
  end

  def destroy
    # Destroy a restaurant
    set_task
    @task.destroy
    redirect_to task_path, status: :see_other
  end

  def check_box(object_name, method, options = {}, checked_value = '1', unchecked_value = '0')
    Tags::CheckBox.new(object_name, method, self, checked_value, unchecked_value, options).render
  end


  private

  def task_params
    # Protects against CRLF injection
    params.require(:task).permit(:title, :details, :completed) #:tables
  end

  def set_task
    # Finds model per id
    @task = Task.find(params[:id])
  end
end

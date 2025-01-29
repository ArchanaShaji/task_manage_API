class TasksController < ApplicationController

	before_action :authenticate_user

	def create
		task = @current_user.tasks.new(task_params)
		if task.save
			render json: { task: task, message: 'Successfully created the task' }, status: :created
		else
	      render json: { errors: task.errors.full_messages }, status: :unprocessable_entity
	    end
	end

	def index
		tasks = @current_user.tasks.page(params[:page]).per(10)
    	render json: tasks, status: :ok
	end

	def show
		task = @current_user.tasks.find(params[:id])
    	render json: task, status: :ok
    	rescue ActiveRecord::RecordNotFound
    		render json: { error: 'Task not found' }, status: :not_found
	end

	def update
		task = @current_user.tasks.find(params[:id])
	    if task.update(task_params)
	      render json: task, status: :ok
	    else
	      render json: { errors: task.errors.full_messages }, status: :unprocessable_entity
	    end
	    rescue ActiveRecord::RecordNotFound
    		render json: { error: 'Task not found' }, status: :not_found
	end

	def destroy
		task = @current_user.tasks.find(params[:id])
    	task.destroy
    	render json: { message: 'Task deleted successfully' }, status: :ok
    	rescue ActiveRecord::RecordNotFound
    		render json: { error: 'Task not found' }, status: :not_found
	end
	

	private

	def task_params
		params.require(:task).permit(:title, :description, :status, :due_date)
	end

	def authenticate_user
		header = request.headers['Authorization']
		token = header.split(' ').last if header
		decoded = JwToken.decode(token)
		@current_user = User.find(decoded[:user_id]) if decoded
	rescue
		render json: { error: 'Unauthorized' }, status: :unauthorized
	end
end

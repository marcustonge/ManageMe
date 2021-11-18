class TasksController < ApplicationController
    before_action :authenticate_user!
    before_action :set_task, only: [:edit, :update, :show, :destroy]
    before_action :set_event

    def new
        @task = Task.new
    end

    def create
        @task = @event.tasks.create(params[:task].permit(:reply, :event_id))
        @task.user_id = current_user.id
        
        respond_to do |format|
        if @task.save
            format.html {redirect_to event_path(@event)}
            format.js # render create.js.erb
        else
            format.html {redirect_to event_path(@event), notice: "Your task was not saved. Please try again if you want to add a task."}
            format.js
        end
    end

    end

    def destroy
        @task = @event.tasks.find(params[:id])
        @task.destroy
        redirect_to event_path(@event)
    end

    private
    def set_event
        @event = Event.find(params[:event_id])
    end

    def set_task
        @task = Task.find(params[:id])
    end

    def task_params
        params.require(:task).permit(:reply)
    end


end

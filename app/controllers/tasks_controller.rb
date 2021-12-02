class TasksController < ApplicationController
    before_action :authenticate_user!
    before_action :set_task, only: [:edit, :update, :show, :destroy]
    before_action :set_event

    def new
        @task = Task.new
    end

    def index
    end

    #method for creating a new task, takes in parameters from the event about the task to be created and creates it unless there's an issue
    #in which case an error message is displayed
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

    #method to destroy a task
    def destroy
        @task = @event.tasks.find(params[:id])
        @task.destroy
        redirect_to event_path(@event)
    end

    #methods used in other parts of the application
    private
    def set_event
        @event = Event.find(params[:event_id])
    end

    def set_task
        @task = Task.find(params[:id])
    end

    #params needs a reply
    def task_params
        params.require(:task).permit(:reply)
    end


end

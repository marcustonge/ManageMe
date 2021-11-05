class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_comment, only: [:edit, :update, :show, :destroy]
    before_action :set_event

    def new
        @comment = Comment.new
    end

    def create
        @comment = @event.comments.create(params[:comment].permit(:reply, :event_id))
        @comment.user_id = current_user.id
        
        respond_to do |format|
        if @comment.save
            format.html {redirect_to event_path(@event)}
            format.js # render create.js.erb
        else
            format.html {redirect_to event_path(@event), notice: "Your comment was not saved. Please try again if you want to comment."}
            format.js
        end
    end

    end

    def destroy
        @comment = @event.comments.find(params[:id])
        @comment.destroy
        redirect_to event_path(@event)
    end

    private
    def set_event
        @event = Event.find(params[:event_id])
    end

    def set_comment
        @comment = Comment.find(params[:id])
    end

    def comment_params
        params.require(:comment).permit(:reply)
    end


end

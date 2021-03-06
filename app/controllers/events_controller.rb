class EventsController < ApplicationController
  #authenticates user before any action, to view active sessions the user must be an admin
  before_action :authenticate_user!
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :must_be_admin, only: [:active_sessions]
  

  # GET /events or /events.json
  def index
    if current_user.admin?
      @events = Event.all
    else
      @events = current_user.events.where(user_id: current_user)
    end
  end

  # GET /events/1 or /events/1.json
  def show
    @task = Task.new
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events or /events.json
  def create
    @event = Event.new(event_params)
    @event.user_id = current_user.id

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: t('controllers.events.created') }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: t('controllers.events.updated') }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: t('controllers.events.destroyed') }
      format.json { head :no_content }
    end
  end

  def active_events
    @active_events = Event.where("end_time > ?", Time.now)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      if Event.exists?(params[:id])
        @event = Event.find(params[:id])
      else
        redirect_to events_path, alert: t('controllers.events.dne')
      end
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:name, :description, :start_time, :end_time, :user_id)
    end

   
    #checks if the user is an admin, if not then they are redirected to the events home page
    def must_be_admin
        unless current_user.admin?
            redirect_to events_path, alert: t('controllers.nopermission')
        end
    end
end
class EventsController < ApplicationController
  before_action :set_event, only: %i[ show edit update destroy ]
  before_action :require_login
  before_action :authorize_organizer!, only: %i[ edit update destroy ]

  # GET /events or /events.json
  def index
    @upcoming_new_events = Event.upcoming.where.not(organizer: current_user).where.not(id: current_user.attended_events.select(:id))

    # apply filters
    if params[:query].present?
      @upcoming_new_events = @upcoming_new_events.where(
        "events.name LIKE ?", "%#{Event.sanitize_sql_like(params[:query])}%"
      )
    end

    if params[:category_ids].present?
      @upcoming_new_events = @upcoming_new_events.where(category_id: params[:category_ids])
    end

    if params[:from_date].present?
      from = Date.parse(params[:from_date]) rescue nil
      @upcoming_new_events = @upcoming_new_events.where("events.date >= ?", from.beginning_of_day) if from
    end

    if params[:to_date].present?
      to = Date.parse(params[:to_date]) rescue nil
      @upcoming_new_events = @upcoming_new_events.where("events.date <= ?", to.end_of_day) if to
    end
  end

  # GET /events/1 or /events/1.json
  def show
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
    @event = current_user.organized_events.build(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: "Event was successfully created." }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @event.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: "Event was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @event.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    @event.destroy!

    respond_to do |format|
      format.html { redirect_to events_path, notice: "Event was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.expect(event: [ :name, :description, :date, :location, :preview_img, :category_id ])
    end

    # only allow an event's organizer to modify or delete it
    def authorize_organizer
      unless @event.organizer == current_user
        redirect_to events_path, alert: "You are not authorized to modify this event."
      end
    end
end

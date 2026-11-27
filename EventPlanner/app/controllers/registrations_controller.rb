class RegistrationsController < ApplicationController
  before_action :set_registration, only: %i[ show edit update destroy ]
  before_action :require_login
  
  # GET /registrations or /registrations.json
  def index
    @registrations = Registration.all
  end

  # GET /registrations/1 or /registrations/1.json
  def show
  end

  # GET /registrations/new
  def new
    @registration = current_user.registrations.build(event_id: params[:event_id])
  end

  # GET /registrations/1/edit
  def edit
  end

  # POST /registrations or /registrations.json
  def create
    @registration = current_user.registrations.build(registration_params)

    if @registration.save
      redirect_to my_events_path, notice: "Successfully registered for #{@registration.event.name}!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /registrations/1 or /registrations/1.json
  def update
    respond_to do |format|
      if @registration.update(registration_params)
        format.html { redirect_to @registration, notice: "Registration was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @registration }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @registration.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /registrations/1 or /registrations/1.json
  def destroy
    @registration.destroy!

    respond_to do |format|
      format.html { redirect_to registrations_path, notice: "Registration was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_registration
      @registration = Registration.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def registration_params
      params.expect(registration: [ :user_id, :event_id, :notes ])
    end
end

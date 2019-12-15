class AttendancesController < ApplicationController
  before_action :authenticate_user!
  before_action :get_event
  before_action :set_attendance, only: [:show, :edit, :update, :destroy]
  before_action :has_applied?, only: [:new, :create]
  before_action :is_right_user?, only: [:show, :edit, :update, :destroy]
  before_action :is_event_future?, only: [:new, :edit, :create, :update]

  # GET /attendances/1
  # GET /attendances/1.json
  def show
  end

  # GET /attendances/new
  def new
    @attendance = @event.attendances.build
  end

  # GET /attendances/1/edit
  def edit
  end

  # POST /attendances
  # POST /attendances.json
  def create
    @attendance = @event.attendances.build(attendance_params)

    respond_to do |format|
      if @attendance.save
        format.html { redirect_to event_attendance_path(@event, @attendance), notice: 'Attendance was successfully created.' }
        format.json { render :show, status: :created, location: @attendance }
      else
        format.html { render :new }
        format.json { render json: @attendance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /attendances/1
  # PATCH/PUT /attendances/1.json
  def update
    respond_to do |format|
      if @attendance.update(attendance_params)
        format.html { redirect_to event_attendance_path(@event, @attendance), notice: 'Attendance was successfully updated.' }
        format.json { render :show, status: :ok, location: @attendance }
      else
        format.html { render :edit }
        format.json { render json: @attendance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attendances/1
  # DELETE /attendances/1.json
  def destroy
    @attendance.destroy
    respond_to do |format|
      format.html { redirect_to event_path(@event), notice: 'Attendance was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def get_event
      @event = Event.find(params[:event_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_attendance
      @attendance = @event.attendances.find(params[:id])
    end

    def has_applied?
      if @event.users.include?(current_user)
        flash[:danger] = 'You have already applied'
        redirect_to user_path(current_user)
      end
    end

    def is_right_user?
      @user = @attendance.user
      unless current_user.admin?
        unless @user.id == current_user.id
          flash[:danger] = 'This is not your attendance'
          redirect_to user_path(current_user)
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def attendance_params
      params.require(:attendance).permit(:user_id, :event_id, :motivation, :comment, :reviewed, :validated)
    end

    def is_event_future?
      unless @event.start_datetime > DateTime.now
        flash[:danger] = 'This event is in the past'
        redirect_to events_path
      end
    end
end

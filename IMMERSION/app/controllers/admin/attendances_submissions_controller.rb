class Admin::AttendancesSubmissionsController < Admin::BaseController
  before_action :set_attendance_submission, only: [:show, :edit, :update]

  def index
    @attendances_submissions = Attendance.where(reviewed: false)
  end

  def show
  end

  def edit
  end

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

  private
    def set_attendance
      @attendance = @event.attendances.find(params[:id])
    end

    def attendance_params
      params.require(:attendance).permit(:user_id, :event_id, :motivation, :comment, :reviewed, :validated)
  end
end

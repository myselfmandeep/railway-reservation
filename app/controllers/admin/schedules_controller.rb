module Admin  
  class SchedulesController < Admin::ApplicationController
    before_action :set_schedule, only: %i[edit update destroy]
    # include AdminAuthorization
    
    def index
      @schedules = Schedule.where.not(destination_station_id: nil)
    end
    
    def new
      @schedule = Schedule.new
    end

    def create
      @schedule = Schedule.new(schedule_params)

      if @schedule.save
        redirect_to admin_schedules_path, notice: "train pulished successfully"
      else
        render :new, status: :unprocessable_entity
      end

    end

    def edit
    end

    def update
      if @schedule.update(schedule_params)
        redirect_to admin_schedules_path, notice: "Schedule updated successfully"
      else
        render :edit, status: :unprocessable_entity
      end

    end

    def destroy
      @schedule.destroy

      redirect_to admin_schedules_path, notice: "Schedule removed successfully"
    end

    private

    def schedule_params
      params.require(:schedule).permit(:train_id, :source_station_id, :destination_station_id, :arrived_at, :departure_at, :distance)
    end

    def set_schedule
      @schedule = Schedule.find(params[:id])
    end
    
  end
end

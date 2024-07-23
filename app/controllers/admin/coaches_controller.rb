module Admin
  class CoachesController < Admin::ApplicationController
    before_action :set_coach, only: %i[edit update destroy]
    
    def index
      @coaches = Coach.all
    end
    
    def new
      @coach = Coach.new
    end

    def create
      @coach = Coach.new(coach_params)

      if @coach.save
        redirect_to admin_coaches_path, notice: "Successfully added coach"
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end
    
    def update
      if @coach.update(coach_params)
        redirect_to admin_coaches_path, notice: "Edited coach #{@coach.name}"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @coach.destroy
      
      redirect_to admin_coaches_path, notice: "Deleted coach #{@coach.name}"
    end

    private

    def coach_params
      # params.require(:coach).permit(:name, :category, :slug_name)
      params.require(:coach).permit(:name, :description, :tier_id)
    end

    def set_coach
      @coach = Coach.find(params[:id])
    end
    
  end
end
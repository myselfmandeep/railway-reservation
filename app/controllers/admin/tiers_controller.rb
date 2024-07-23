module Admin  
  class TiersController < ApplicationController
    before_action :set_tier, only: %i[edit update destroy]

    def index
      @tiers = Tier.all
    end
    
    def new
      @tier = Tier.new
    end
    
    def create
      @tier = Tier.new(tier_params)

      if @tier.save
        redirect_to admin_tiers_path, notice: "Successfully Added new tier #{@tier.name}"
      else
        render :new, status: :unprocessable_entity
      end

    end

    def edit
    end
    
    def update
      if @tier.update(tier_params)
        redirect_to admin_tiers_path, notice: "Updated Tier #{@tier.name}"
      else
        render :edit, status: :unprocessable_entity
      end

    end

    def destroy
      @tier.destroy

      redirect_to admin_tiers_path, notice: "successfully deleted record #{@tier.name}"
    end
    
    
    private
    
    def tier_params
      params.require(:tier).permit(:name, :short_form, :price_per_km)
    end

    def set_tier
      @tier = Tier.find(params[:id])
    end
    
  end
end
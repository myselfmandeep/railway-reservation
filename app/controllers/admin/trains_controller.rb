module Admin
  class TrainsController < Admin::ApplicationController
    before_action :set_train, only: %i[edit update destroy]
    
    def index
      # @trains = Train.order_by_routes_count
      @trains = Train.order(created_at: :desc)
    end
    
    def new
      @train = Train.new
    end
    
    def create
      @train = Train.new(train_params)
      
      if @train.save
        redirect_to admin_trains_path, notice: "Train has been successfully created"
      else
        render :new, status: :unprocessable_entity
      end
    end

    # def show
    #   # @train = Train.find(params[:id])
    # end
    
    def edit
    end
    
    def update
      if @train.update(train_params)
        redirect_to admin_trains_path, notice: "Train #{@train.name} has been updated!"
      else
        render :edit, notice: "Something went wrong"
      end
    end
    
    def destroy
      @train.destroy

      redirect_to admin_trains_path, notice: "#{@train.name} has been deleted"
    end
    
    private
    
    def train_params
      # params.require(:train).permit(:name, :uniq_number, :category, coaches: [], working_days: []).merge!({uniq_number: generate_train_number})
      # params.require(:train).permit(:name, :uniq_number, :category, coaches: [], working_days: []).merge!({working_days: params[:working_days], coaches: params[:coaches]})
      params.require(:train)
            .permit(:name, :category)
            .merge!({
                      working_days: params[:working_days], coaches: params[:coaches],
                      uniq_number: get_random_number(5)
                    })
    end

    def set_train
      @train = Train.find(params[:id])
    end

  end
end
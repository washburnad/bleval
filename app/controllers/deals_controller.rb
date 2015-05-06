class DealsController < ApplicationController
  def index
    @deals = Deal.all
  end

  def new
    @deal = Deal.new
  end

  def show
    @deal = Deal.includes(:events, :tasks).find params[:id]
  end

  def create
    @deal = Deal.create deal_params
    puts deal_params
    puts @deal
    if @deal.valid?
      redirect_to deal_path @deal
    else
      render :new, :status => :unprocessable_entity
    end
  end

  def edit
    @deal = Deal.find params[:id]
  end

  def update
    @deal = Deal.find params[:id]
    @deal.update_attributes deal_params

    if @deal.valid?
      redirect_to deal_path @deal
    else
      render :new, :status => :unprocessable_entity
    end  
  end

  private

  def deal_params
    params.
      require(:deal).
      permit(
        :lead_id,
        :agent_id,
        :current_stage_id,
        :property_id)
  end

  def update_deal_connections

  end
end

class LeadsController < ApplicationController
  def create
    @lead = Lead.create lead_params
    if @lead.valid?
      redirect_to lead_path @lead
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @lead = Lead.find params[:id]
  end

  def edit
    @lead = Lead.find params[:id]
  end

  def update
    @lead = Lead.find params[:id]
    @lead.update_attributes lead_params
    if @lead.valid?
      redirect_to lead_path @lead
    else
      render :new, status: :unprocessable_entity
    end
  end 

  private

  def lead_params
    params.
      require(:lead).
        permit(
          :first_name,
          :last_name,
          :agent_id,
          :lead_type_id,
          :lead_status_id,
          :lead_priority_id)
  end
end

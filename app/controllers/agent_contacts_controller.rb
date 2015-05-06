class AgentContactsController < ApplicationController
  def create
    @agent_contact = AgentContact.create agent_contact_params
    if @agent_contact.valid?
      redirect_to agents_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def agent_contact_params
    params.
      require(:agent_contact).
      permit(
        :property_id,
        :comments,
        :lead_id,
        :agent_id)
  end
end

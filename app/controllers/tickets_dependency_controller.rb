class TicketsDependencyController < ApplicationController

  private
  def find_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end

  def authorize_from_ticket
    find_ticket
    if @ticket.author == current_user or current_user.is_tech?

    else
      flash[:error] = t("flash_messages.tickets.not_authorized")
    end
  end
end
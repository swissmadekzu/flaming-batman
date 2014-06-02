class Api::TicketsController < ApplicationController

  def new
    @tickets = Ticket.where(is_invalid: false, aasm_state: "new")
    render json: @tickets.to_json(include: :author)
  end
  
  def open
    @tickets = Ticket.where(is_invalid: false, aasm_state: "open")
    render json: @tickets.to_json(include: :author)
  end
  
end
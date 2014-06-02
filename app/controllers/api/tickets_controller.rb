class Api::TicketsController < ApplicationController

  def new
    @tickets = Ticket.where(is_invalid: false, aasm_state: "new")
    render json: @tickets
  end
  
  def open
    @tickets = Ticket.where(is_invalid: false, aasm_state: "open")
    render json: @tickets
  end
  
end
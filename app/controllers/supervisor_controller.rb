class SupervisorController < ApplicationController
  
  layout "minoral"
  
  before_action :check_supervisor
  
  def index
    @title = "Superviseur"
    @tickets = Ticket.all  
  end
  
  def supervise
    @ticket = Ticket.find(params[:id])
    @title = @ticket.full_name + " | Superviseur"
  end
  
  private
  def check_supervisor
    return false unless (current_user.is_supervisor? or current_user.is_tech?)
  end
end
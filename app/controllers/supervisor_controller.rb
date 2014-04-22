class SupervisorController < ApplicationController
  before_action :check_supervisor
  
  def index
    @tickets = Ticket.all  
  end
  
  private
  def check_supervisor
    return false unless (current.user.is_supervisor? or current_user.is_tech?)
  end
end
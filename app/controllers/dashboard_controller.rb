class DashboardController < ApplicationController

before_action :authorize

  def index
    @new_tickets = current_user.is_tech? ? Ticket.where(status: Status.find_by(title: "new")) : current_user.tickets.where(status: Status.find_by(title: "new"))
    @open_tickets = current_user.is_tech? ? current_user.work_tickets.where(status: Status.find_by(title: "open")) : current_user.tickets.where(status: Status.find_by(title: "open"))
    @solved_tickets = current_user.is_tech? ? current_user.work_tickets.where(status: Status.find_by(title: "solved")) : current_user.tickets.where(status: Status.find_by(title: "solved"))
  end

end
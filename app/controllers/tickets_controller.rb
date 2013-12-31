class TicketsController < ApplicationController
  before_action :authorize

  def index

  end

  def tech
    @tickets = case params[:filter]
      when "new" then Ticket.where(status: Status.find_by(title: "new"))
      when "open" then current_user.work_tickets.where(status: Status.find_by(title: "open"))
      when "solved" then current_user.work_tickets.where(status: Status.find_by(title: "solved"))
      when "invalid" then current_user.work_tickets.where(status: Status.find_by(title: "invalid"))
    end
  end
end
class TicketsController < ApplicationController
  before_action :authorize
  before_action :require_tech, only: [:treat, :end_treatment]

  def index
    @tickets = case params[:filter]
      when "new" then current_user.tickets.where(status: Status.find_by(title: "new"))
      when "open" then current_user.tickets.where(status: Status.find_by(title: "open"))
      when "solved" then current_user.tickets.where(status: Status.find_by(title: "solved"))
      when "invalid" then current_user.tickets.where(status: Status.find_by(title: "invalid"))
      else current_user.tickets.order("status_id ASC")
    end
  end

  def tech
    @tickets = case params[:filter]
      when "new" then Ticket.where(status: Status.find_by(title: "new"))
      when "open" then current_user.work_tickets.where(status: Status.find_by(title: "open"))
      when "solved" then Ticket.where(status: Status.find_by(title: "solved"))
      when "invalid" then Ticket.where(status: Status.find_by(title: "invalid"))
      else Ticket.order("status_id ASC")
    end
  end

  def show
    if current_user.is_tech?
      @ticket = Ticket.find(params[:id])
    else
      @ticket = current_user.tickets.find(params[:id])
    end
  end

  def new
    @ticket = current_user.tickets.new
  end

  def create
    @ticket = current_user.tickets.new(ticket_params)
    if @ticket.save
      flash[:notice] = t("flash_messages.tickets.created_successfully")
      TicketMailer.ticket_created(@ticket).deliver
      redirect_to ticket_path(@ticket)
    else
      flash[:error] = t("flash_messages.tickets.error_in_creation")
      render action: :new
    end
  end

  def edit
    if current_user.is_tech?
      @ticket = Ticket.find(params[:id])
    else
      @ticket = current_user.tickets.find(params[:id])
    end
  end

  def update
    if current_user.is_tech?
      @ticket = Ticket.find(params[:id])
    else
      @ticket = current_user.tickets.find(params[:id])
    end
    if @ticket.update_attributes(ticket_params)
      flash[:notice] = t("flash_messages.tickets.updated_successfully")
      redirect_to ticket_path(@ticket)
    else
      flash[:error] = t("flash_messages.tickets.error_in_update")
      render action: :edit
    end
  end

  def destroy
    if current_user.is_tech?
      @ticket = Ticket.find(params[:id])
    else
      @ticket = current_user.tickets.find(params[:id])
    end
    if @ticket.destroy
      flash[:notice] = t("flash_messages.tickets.deleted_successfully")
      redirect_to (current_user.is_tech? ? tech_tickets_path(filter: "new") : tickets_path(filter: "new"))
    else
      flash[:error] = t("flash_messages.tickets.error_in_delete")
      redirect_to ticket_path(@ticket)
    end
  end

  def treat
    @ticket = Ticket.find(params[:id])
    @ticket.update_attributes(status: Status.find_by(title: "open"), treatment_date: DateTime.now.utc, tech_id: current_user.id)
    TicketMailer.ticket_open(@ticket).deliver
    redirect_to ticket_path(@ticket)
  end

  def end_treatment
    @ticket = Ticket.find(params[:id])
    @ticket.update_attributes(status: Status.find_by(title: "solved"), end_treatment_date: DateTime.now.utc)
    TicketMailer.ticket_close(@ticket).deliver
    redirect_to ticket_path(@ticket)
  end

  private
  def ticket_params
    params.required(:ticket).permit(:author_id, :tech_id, :title, :description, :treatment_date, :end_treatment_date, :status_id, :emergency_id, :category_id)
  end

  def require_tech
    redirect_to ticket_path(@ticket) unless current_user.is_tech?
  end
end
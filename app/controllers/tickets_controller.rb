class TicketsController < ApplicationController
  
  layout "minoral"
  
  before_action :authorize
  before_action :require_tech, only: [:treat, :end_treatment]

  def index
    @title = t("tickets.my_tickets")
    @tickets = case params[:filter]
      when "new" then current_user.tickets.where(is_invalid: false, aasm_state: "new")
      when "open" then current_user.tickets.open.where(is_invalid: false)
      when "pending" then current_user.tickets.pending.where(is_invalid: false)
      when "solved" then current_user.tickets.solved.where(is_invalid: false)
      when "invalid" then current_user.tickets.where(is_invalid: true)
      else current_user.tickets.where(is_invalid: true)
    end
  end

  def tech
    @title = t("tickets.my_tickets")
    @tickets = case params[:filter]
      when "new" then Ticket.where(is_invalid: false, aasm_state: "new")
      when "open" then Ticket.open.where(is_invalid: false)
      when "pending" then Ticket.pending.where(is_invalid: false)
      when "solved" then Ticket.solved.where(is_invalid: false)
      when "invalid" then Ticket.where(is_invalid: true)
      else Ticket.order("status_id ASC")
    end
  end

  def show
    if current_user.is_tech?
      @ticket = Ticket.find(params[:id])
    else
      @ticket = current_user.tickets.find(params[:id])
    end
    @title = @ticket.full_name
  end

  def new
    @ticket = current_user.tickets.new
    @title = t("tickets.new_ticket")
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
    @title = t("tickets.edit_ticket")
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
    if @ticket.may_open_ticket?
      @ticket.open_ticket
      @ticket.treatment_date = DateTime.now.utc
      @ticket.save
      #@ticket.update_attributes(status: Status.find_by(title: "open"), treatment_date: DateTime.now.utc, tech_id: current_user.id)
      TicketMailer.ticket_open(@ticket).deliver
    end
    redirect_to ticket_path(@ticket)
  end

  def end_treatment
    @ticket = Ticket.find(params[:id])
    if @ticket.may_wait_for_validation?
      @ticket.wait_for_validation
      @ticket.save
      #@ticket.update_attributes(status: Status.find_by(title: "solved"), end_treatment_date: DateTime.now.utc)
      TicketMailer.ticket_closed(@ticket).deliver
    end
    redirect_to ticket_path(@ticket)
  end
  
  def reopen_ticket
    @ticket = Ticket.find(params[:id])
    if @ticket.may_reopen?
      @ticket.reopen
      @ticket.save
    end
    redirect_to ticket_path(@ticket)
  end      
        
  def validate_solution
    @ticket = Ticket.find(params[:id])
    if @ticket.may_validate?
      @ticket.validate
      @ticket.end_treatment_date = DateTime.now.utc
      @ticket.save
    end
    redirect_to ticket_path(@ticket)
  end

  private
  def ticket_params
    params.required(:ticket).permit(:author_id, :tech_id, :title, :description, :treatment_date, :end_treatment_date, :status_id, :emergency_id, :category_id, :is_invalid, :stupid)
  end

  def require_tech
    redirect_to ticket_path(@ticket) unless current_user.is_tech?
  end
end

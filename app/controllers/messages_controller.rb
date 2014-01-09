class MessagesController < TicketsDependencyController

  before_action :authorize_from_ticket, only: :new
  before_action :authorize_from_message, only: :destroy

  def new
    @message = @ticket.messages.new(author: current_user)
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      flash[:notice] = t("flash_messages.messages.created_successfully")
      TicketMailer.ticket_message(@message.ticket).deliver
      redirect_to ticket_path(@message.ticket)
    else
      flash[:error] = t("flash_messages.messages.error_creation")
      render action: :new
    end
  end

  def destroy
    if @message.destroy
      flash[:notice] = t("flash_messages.messages.deleted_successfully")
      redirect_to(:back)
    else
      flash[:error] = t("flash_messages.messages.error_deletion")
      redirect_to(:back)
    end
  end

  private
  def message_params
    params.required(:message).permit(:author_id, :ticket_id, :title, :body)
  end

  def authorize_from_message
    @message = Message.find(params[:id])
    unless @message.author == current_user
      flash[:error] = t("flash_messages.common.not_proprietary")
      redirect_to(:back)
    end
  end

end
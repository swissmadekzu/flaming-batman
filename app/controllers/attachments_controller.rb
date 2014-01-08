class AttachmentsController < TicketsDependencyController

  before_action :authorize_from_ticket, only: :new

  def new
    @attachment = @ticket.attachments.new
  end

  def create
    @attachment = Attachment.new(attachment_params)
    if @attachment.save
      flash[:notice] = t("flash_messages.attachments.created_successfully")
      redirect_to ticket_path(@attachment.ticket)
    else
      flash[:error] = t("flash_messages.attachments.error_creation")
      render action: :new
    end
  end

  def destroy
    @attachment = Attachment.find(params[:id])
    if @attachment.destroy
      flash[:notice] = t("flash_messages.attachments.deleted_successfully")
      redirect_to(:back)
    else
      flash[:error] = t("flash_messages.attachments.error_deletion")
      redirect_to(:back)
    end
  end

  private
  def attachment_params
    params.required(:attachment).permit(:ticket_id, :attachment)
  end

end
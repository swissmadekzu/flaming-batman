class TicketMailer < ActionMailer::Base
  default from: "it.support@militarymegastore.ch"

  def ticket_created(ticket)
    @ticket = ticket
    mail(to: @ticket.author.email, subject: "#{t("mailers.tickets.new_ticket")} ##{@ticket.id}")
  end

  def ticket_message(ticket)
    @ticket = ticket
    emails_list = [@ticket.author.email]
    emails_list << @ticket.tech.email if @ticket.tech.present?
    mail(to: emails_list, subject: "#{t("mailers.tickets.new_message")} ##{@ticket.id}")
  end

  def ticket_open(ticket)
    @ticket = ticket
    mail(to: @ticket.author.email, subject: t("mailers.tickets.ticket_open", ticket_id: @ticket.id))
  end

  def ticket_closed(ticket)
    @ticket = ticket
    mail(to: @ticket.author.email, subject: t("mailers.tickets.ticket_close", ticket_id: @ticket.id))
  end
end

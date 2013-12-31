class Ticket < ActiveRecord::Base
  belongs_to :author, inverse_of: :tickets
  belongs_to :techie, inverse_of: :work_tickets
end

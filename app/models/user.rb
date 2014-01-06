class User < ActiveRecord::Base
include Clearance::User
  
  has_many :tickets, class_name: Ticket, foreign_key: :author_id, inverse_of: :author
  has_many :work_tickets, class_name: Ticket, foreign_key: :tech_id, inverse_of: :techie

end

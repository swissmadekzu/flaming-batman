class Message < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :author, class_name: User
end

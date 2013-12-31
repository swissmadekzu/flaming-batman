class Emergency < ActiveRecord::Base
  has_many :tickets
end

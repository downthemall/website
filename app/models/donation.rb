class Donation < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :amount
end

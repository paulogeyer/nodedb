class Node < ActiveRecord::Base
  acts_as_mappable
  belongs_to :user
  validates_presence_of :user
  def address
  end
end

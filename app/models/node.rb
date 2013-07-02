class Node < ActiveRecord::Base
  TYPES = ["WORKING", "PLANNING"]
  attr_reader :TYPES
  acts_as_mappable
  belongs_to :user
  validates_presence_of :user
end

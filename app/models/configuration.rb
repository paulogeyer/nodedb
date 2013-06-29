class Configuration < ActiveRecord::Base
  def self.[] name
    self.find_by_name(name).try(:value)
  end

  def self.[]= name, value
    configuration = self.find_or_create_by_name(name)
    configuration.value = value
    configuration.save
  end
end

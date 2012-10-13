class Report < ActiveRecord::Base
  attr_accessible :deadline, :description, :link, :name
end

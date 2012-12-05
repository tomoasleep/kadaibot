# -*- coding:utf-8 -*-

class Report < ActiveRecord::Base
  attr_accessible :deadline, :description, :link, :name

  def self.stodatetime(str)
    jajp = Horai::JaJP.new
    jajp.parse(str).tapp
  end

  def left_day
    day_start = Date.today.to_datetime
    left_day = 0
    0.upto(365) do |i|
      if day_start + i < self.deadline
        left_day = i
      else
        break
      end
    end
    left_day
  end


end

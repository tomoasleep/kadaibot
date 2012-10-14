# -*- coding:utf-8 -*-

class Report < ActiveRecord::Base
  attr_accessible :deadline, :description, :link, :name

  def self.stodatetime(str)
    jajp = Horai::JaJP.new
    jajp.parse(str).tapp
  end
end

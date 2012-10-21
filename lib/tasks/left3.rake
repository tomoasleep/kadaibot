# -*- coding:utf-8 -*-

desc "残り3日の課題を教えるボット"
task :left3 => :environment do
  p "Reports"
  Report.where("deadline > ? and deadline < ?", DateTime.now, DateTime.now + 3).each do |repo|
    left_day =  DateTime.now - repo.deadline
    submit_text = "締切まであと#{left_day}:#{repo.name}, 締め切り:#{repo.deadline}, #{repo.link}".tapp
    Twitter.update(submit_text)
  end
end


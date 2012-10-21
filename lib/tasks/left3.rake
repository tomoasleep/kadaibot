# -*- coding:utf-8 -*-

desc "残り3日の課題を教えるボット"
task :left3 => :environment do
  p "Reports"
  Report.where("deadline > ? and deadline < ?", DateTime.now, DateTime.now + 3).each do |repo|
    left_day = 1 
    0.upto(3) do |i|
      left_day = i if DateTime.now + i < repo.deadline
    end
    submit_text = "締切まであと#{left_day}日以内:#{repo.name}, 締め切り:#{repo.deadline}, #{repo.link}".tapp
    Twitter.update(submit_text)
  end
end


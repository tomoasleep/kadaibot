# -*- coding:utf-8 -*-

desc "残り3日の課題を教えるボット"
task :left3 => :environment do
  p "Reports"
  Report.where("deadline > ? and deadline < ?", DateTime.now, DateTime.now + 5).each do |repo|
    Twitter.update("あと5日以内:#{repo.name}, 締め切り:#{repo.deadline}, #{repo.link}".tapp)
  end
end


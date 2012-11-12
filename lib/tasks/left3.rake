# -*- coding:utf-8 -*-

desc "残り3日の課題を教えるボット"
task :left3 => :environment do
  p "Reports"
  day_start = Date.today.to_datetime

  repos = Report.where("deadline > ? and deadline < ?", day_start, day_start + 3)
  if repos.length > 0
    submit_text = "--残り3日切った課題: #{DateTime.now}--"
    Twitter.update(submit_text) unless ENV['RAILS_ENV'] == "development"
  end
  repos.each do |repo|
    left_day = 1 
    0.upto(3) do |i|
      left_day = i if day_start + i < repo.deadline
    end

    submit_text = ""
    if left_day == 0
      submit_text = "【今日締切】#{repo.name}, 締切:#{repo.deadline}, #{repo.link}".tapp
    elsif left_day == 1
      submit_text = "【明日まで】#{repo.name}, 締切:#{repo.deadline}, #{repo.link}".tapp
    else
      submit_text = "【あと#{left_day}日】#{repo.name}, 締切:#{repo.deadline}, #{repo.link}".tapp
    end
    Twitter.update(submit_text) unless ENV['RAILS_ENV'] == "development"
  end

end


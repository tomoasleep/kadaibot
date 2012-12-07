# -*- coding:utf-8 -*-

desc "残り3日の課題を教えるボット"
task :left3 => :environment do
  p "Reports"
  day_start = Date.today.to_datetime

  repos = Report.where("deadline > ? and deadline < ?", day_start, day_start + 8)
  if repos.length > 0
    submit_text = "--締切近い課題: #{DateTime.now}--"
    Twitter.update(submit_text) if ENV['RAILS_ENV'] == "production"
  end
  repos.each do |repo|
    p repo
    left_day = repo.left_day

    submit_text = ""
    case left_day
    when 2..7 
      submit_text = "【あと#{left_day}日】#{repo.name}, 締切:#{repo.deadline}, #{repo.link}".tapp
    when 1
      submit_text = "【明日まで】#{repo.name}, 締切:#{repo.deadline}, #{repo.link}".tapp
    when 0
      submit_text = "【今日締切】#{repo.name}, 締切:#{repo.deadline}, #{repo.link}".tapp
    else
      next
    end

    Twitter.update(submit_text) if ENV['RAILS_ENV'] == "production"
  end

end


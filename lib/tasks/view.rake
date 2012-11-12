# -*- coding:utf-8 -*-

desc "check Reports"
task :view => :environment do
  repos = Report.where("deadline > ?", DateTime.now).order("deadline")
  repos.each do |repo| 
    puts "#{repo.name}, #{repo.deadline}\n#{repo.description}\n-> #{repo.link}\n\n"
  end
end

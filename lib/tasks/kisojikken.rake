# -*- coding:utf-8 -*-

task :kisojikken => :environment do
  0.upto(ENV["KISOJIKKEN_MAX"].to_i) do |i|
    break unless scraping(i) 
  end
end

def scraping(number)
  begin 
    agent = Mechanize.new 

    # scraping
    doc = agent.get("http://hagi.is.s.u-tokyo.ac.jp/kisojikken/c#{number}.html")
    titles = doc.search("h3.number")
    problems = doc.search("div.problem")


    # building Report
    reports = titles.length.times do |i|
      attrs = {
        name: titles[i].content.tapp,
        description: Sanitize.clean(problems[i].search("p").first.content).tapp.chomp.gsub(/^\n/, ""),
        deadline: Report.stodatetime(problems[i].search("p.deadline").first.content.gsub(/^締切:/, "").tapp),
        link: doc.uri.to_s.tapp
      }
      repo = Report.new(attrs).tapp{|r| r.inspect}
      repo.save if Report.where("name = ? and link = ?", repo.name, repo.link).empty?
    end

    return true 
  rescue Mechanize::Error
    return false
  end


end



#  def to_s 
#    "Title:#{@title}, Content:#{@content}, Deadline:#{@deadline}\n"
#  end

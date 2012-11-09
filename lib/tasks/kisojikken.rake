# -*- coding:utf-8 -*-

task :kisojikken => :environment do

  target = ["c", "s", "ad"]
  target.each do |w|
    notfailed = true 
    0.upto(ENV["KISOJIKKEN_MAX"].to_i) do |i|
      if scraping(i, :target_name => w) 
        notfailed = true
      else
        break unless notfailed
        notfailed = false
      end
    end
  end
end

def scraping(number, options = {})
  options = {
    :target_name => "c"
  }.merge(options)
  begin 
    agent = Mechanize.new 

    # scraping
    doc = agent.get("http://hagi.is.s.u-tokyo.ac.jp/kisojikken/#{options[:target_name]}#{number}.html")
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
      next if attrs[:deadline] < Time.now
      if (repos = Report.where("name = ? and link = ?", attrs[:name], attrs[:link])).empty?
        repo = Report.new(attrs).tapp{|r| r.inspect}
        repo.save
        p "save: #{repo.inspect}"
      else
        repos.update_all(attrs)
        p "update: #{repos.inspect}"
      end
    end
    return true 
  rescue SocketError
    return false
  rescue Mechanize::Error
    return false
  end 

end



#  def to_s 
#    "Title:#{@title}, Content:#{@content}, Deadline:#{@deadline}\n"
#  end

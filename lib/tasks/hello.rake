# -*- coding:utf-8 -*-

desc "テスト用のつぶやきタスクです"
task :hello => :environment do
  
  Twitter.update("Hello World!")
end

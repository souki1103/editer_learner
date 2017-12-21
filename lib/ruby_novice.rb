require 'fileutils'
require 'colorize'
require 'thor'

module RubyNovice
  class CLI < Thor
=begin
    desc 'open [DIR]', 'open new terminal on DIR or pwd'
    def open(*argv)
      if argv[0]==nil
        pwd = Dir.pwd
      else
        pwd = File.realdirpath(argv[0])
      end
      system "osascript -e 'tell application \"Terminal\" to do script \"cd #{pwd} \" '"
    end
=end
    
    #default_task :open
  desc 'check', 'check your typing skill.'
  def check(*argv)    
    random = rand(1..4)
    s = %(#{random}.rb)
    
    FileUtils.cp("/Users/souki/editor_learner/lib/mondai/#{s}", "question.rb")
    p random
    open
    
    start_time = Time.now
    loop do
      sleep(1)
      if File.exist?("/Users/souki/editor_learner/question.rb") && File.exist?("/Users/souki/editor_learner/answer.rb")
        if FileUtils.compare_file("/Users/souki/editor_learner/question.rb", "/Users/souki/editor_learner/answer.rb") == true
          break
        end
      end
    end
    end_time = Time.now
    time = end_time - start_time - 1
    
    puts "#{time} sec"
  end
  no_commands do
    def open
      pwd = Dir.pwd
      system "osascript -e 'tell application \"Terminal\" to do script \"cd #{pwd} \" '"
    end
  end
end
end
#RubyNovice::CLI.start(ARGV)

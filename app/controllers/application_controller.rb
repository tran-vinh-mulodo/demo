class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def check_aa
    puts "acnsdcscsdfsd" 
  end  
  
  def check_abc
    print 'adbsdfsdf'
    puts 'check abc'
  end 
  
  def new_method
    puts 1+1
  end
  
end

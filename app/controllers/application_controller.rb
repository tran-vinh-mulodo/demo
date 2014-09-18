class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def check_abc
    puts 'check abc'
  end  
  
  def other_method
    puts "other method"
  end
    
end

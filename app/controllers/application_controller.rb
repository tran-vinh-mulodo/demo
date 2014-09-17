class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def check_abc
    puts 'check abc'
  end  
    
end

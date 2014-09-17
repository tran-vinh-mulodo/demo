=begin
require 'net/http'
scheduler = Rufus::Scheduler.start_new
scheduler.every("5s") do
  #(1..20).each {|e|
        uri = URI.parse('http://localhost:3000/export/send_mail')
        request = Net::HTTP.post_form(uri, {email: "luong.phuc@mulodo.com"})
        puts request.body
  #}
end
=end
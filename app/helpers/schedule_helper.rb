require 'net/http'
module ScheduleHelper
  class Schedule_rufu
    @@LIST_SCHEDULE = {}

    def self.create_schedule(name_schedule,data)
      @@LIST_SCHEDULE[name_schedule.to_sym] = Rufus::Scheduler.new
      #@@LIST_SCHEDULE[name_schedule.to_sym].at Time.now+3 do
      @@LIST_SCHEDULE[name_schedule.to_sym].every '5s' do
        do_schedule(data)
        @@LIST_SCHEDULE.delete(name_schedule.to_sym)
      end
    end

    def self.view_list_schedule
      return @@LIST_SCHEDULE.count
    end

    def self.del_schedule(name_schedule)
      return false if @@LIST_SCHEDULE[name_schedule.to_sym].nil?
      @@LIST_SCHEDULE[name_schedule.to_sym].stop({})
      @@LIST_SCHEDULE.delete(name_schedule.to_sym)
      return true
    end

    def self.do_schedule(data)
      puts "Schedulte #{data[:email]}"
      (1..20).each {|e|
        uri = URI.parse('http://localhost:3000/export/send_mail')
        request = Net::HTTP.post_form(uri, data)
        puts request.body
      }
    end

  end
end
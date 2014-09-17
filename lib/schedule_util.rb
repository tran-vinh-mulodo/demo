class ScheduleUtil
  def self.singleton(opts={})
     @singleton ||= Rufus::Scheduler.new(opts)
  end
end
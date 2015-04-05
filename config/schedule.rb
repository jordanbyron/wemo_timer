require_relative '../lib/sunset'

set :output, "/usr/local/wemo_timer/log/cron_log.log"
job_type :command, "cd :path && :task :output"

every :day, :at => '9:00 am' do
  command "vendor/bundle/ruby/2.1.0/gems/whenever-0.9.4/bin/whenever --update-crontab"
end

every :day, :at => '10:45 pm' do
  command "bin/light Front off"
end

sunset = Sunset.at
front_lights_on_at = sunset - (30 * 60) # 30 minutes before sunset

every :day, :at => front_lights_on_at.strftime('%l:%M %P') do
  command "bin/light Front on"
end

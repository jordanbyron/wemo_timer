dir = File.expand_path(__dir__ + '/..')
God.watch do |w|
  w.name  = "floodlights"
  w.group = "wemo_sync"
  w.dir   = dir
  w.start = dir + "/bin/sync"
  w.log   = dir + "/log/sync.log"
  w.keepalive
end

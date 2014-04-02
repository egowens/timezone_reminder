#!/usr/bin/env ruby

# You might want to change this
ENV["RAILS_ENV"] ||= "production"

root = File.expand_path(File.dirname(__FILE__))
root = File.dirname(root) until File.exists?(File.join(root, 'config'))
Dir.chdir(root)

require File.join(root, "config", "environment")

$running = true
Signal.trap("TERM") do 
  $running = false
end

Rails.logger.auto_flushing = true if Rails.logger.respond_to?(:auto_flushing)

while $running do
  sender = Sender.next_for_delivery
  if sender
    Sender.deliver
  else
    sleep 15
  end
end

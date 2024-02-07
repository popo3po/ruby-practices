#! /bin/sh ruby
require 'optparse/date'

today_mon = Date.today.mon
today_year = Date.today.year
params = ARGV.getopts("m:","y:")
params_mon = params["m"]||today_mon
params_year = params["y"]||today_year

puts "#{params_mon}月\s#{params_year}".center(20)
puts "日\s月\s火\s水\s木\s金\s土\n"

fast_day = Date.new(params_year.to_i, params_mon.to_i, +1)
last_day = Date.new(params_year.to_i, params_mon.to_i, -1)

(fast_day..last_day).each do |x| 
  if x == fast_day && x == Date.today    
    wday = x.wday
    wday.times {print "\s\s\s"}
    print "\e[7m#{fast_day.day.to_s.rjust(2)}\e[0m\s" 

  elsif x == fast_day    
    wday = x.wday
    wday.times {print "\s\s\s"}
    print fast_day.day.to_s.center(3)
  
  elsif x.saturday? && x == Date.today
    puts "\e[7m#{x.day.to_s.rjust(2)}\e[0m\s" 

  elsif x.saturday?
    puts x.day.to_s.center(3)
  
  elsif x == last_day && x == Date.today 
    puts "\e[7m#{x.day.to_s.rjust(2)}\e[0m\s"
  
  elsif x == last_day 
    puts x.day.to_s.center(3)
  
  elsif x == Date.today && x == Date.today
    print "\e[7m#{x.day.to_s.rjust(2)}\e[0m\s"
  
  else x == Date.today
    print x.day.to_s.center(3)
  end
end

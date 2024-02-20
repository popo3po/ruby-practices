#! /bin/sh ruby
require 'optparse/date'

today_mon = Date.today.mon
today_year = Date.today.year
params = ARGV.getopts("m:","y:")
params_mon = params["m"]||today_mon
params_year = params["y"]||today_year

puts "#{params_mon}月\s#{params_year}".center(20)
puts "日\s月\s火\s水\s木\s金\s土\n"

first_day = Date.new(params_year.to_i, params_mon.to_i, +1)
last_day = Date.new(params_year.to_i, params_mon.to_i, -1)

first_day.wday.times {print "\s\s\s"}

(first_day..last_day).each do |x| 
  day_center = x.day.to_s.center(3) 
  saturday_rjust = x.day.to_s.rjust(2) 

  if x == Date.today
    print "\e[7m#{saturday_rjust}\e[0m\s"
  else
    print day_center
  end
  
  if x.saturday?
    print "\n"
  end
end

puts "\n" 

#!/usr/bin/env ruby
# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')
shots = []

scores.each do |s|
  if s == 'X'
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end

frames = []
shots.each_slice(2) do |s|
  frames << s
end

point = 0
frames.each_with_index do |frame, index|
  next_frame = frames[index + 1]
  next2_frame = frames[index + 2]
  point += if index < 9 # 1〜9フレーム目までの計算
             if frame[0] == 10 && next_frame[0] == 10 && next2_frame[0] == 10 # 3フレームストライクだった場合
               20 + next2_frame[0]
             elsif frame[0] == 10 && next_frame[0] == 10 # 2フレームストライクだった場合
               20 + next2_frame[0]
             elsif frame[0] == 10 # ストライクの場合
               10 + next_frame[0] + next_frame[1]
             elsif frame.sum == 10 # スペアの場合
               frame.sum + next_frame[0]
             else # 合計が9未満の場合
               frame.sum
             end
           else # 10フレームの計算
             frame.sum
           end
end

puts point
